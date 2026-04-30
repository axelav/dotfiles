-- qmd semantic search picker.
-- Prompts for a query, runs `qmd query --json`, and feeds results to fzf-lua
-- with the builtin previewer so <CR> opens the file at the matching line.

return {
  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = {
      {
        "<leader>fq",
        function()
          local fzf = require("fzf-lua")

          local function read_collection_paths()
            local index_path = vim.fn.expand("~/.config/qmd/index.yml")
            if vim.fn.filereadable(index_path) == 0 then
              return {}
            end
            local paths = {}
            local current_name
            for _, line in ipairs(vim.fn.readfile(index_path)) do
              local name = line:match("^%s%s([%w_-]+):%s*$")
              if name then
                current_name = name
              elseif current_name then
                local path = line:match("^%s%s%s%s+path:%s*(.+)%s*$")
                if path then
                  paths[current_name] = path
                end
              end
            end
            return paths
          end

          local function resolve_qmd_uri(uri, collection_paths)
            local name, rel = uri:match("^qmd://([^/]+)/(.*)$")
            if not name or not collection_paths[name] then
              return nil
            end
            return collection_paths[name] .. "/" .. rel
          end

          local function snippet_line_and_text(snippet)
            -- Snippets look like: "@@ -7,4 @@ (6 before, 24 after)\nactual content..."
            local start_line = tonumber(snippet:match("@@ %-(%d+)")) or 1
            local content = snippet:gsub("^@@[^\n]*\n", "")
            local first = content:match("([^\n]+)") or ""
            return start_line, first
          end

          vim.ui.input({ prompt = "qmd query: " }, function(query)
            if not query or query == "" then
              return
            end

            vim.notify("qmd: searching…", vim.log.levels.INFO)

            local stdout = {}
            vim.system({ "qmd", "query", query, "-n", "25", "--json" }, {
              text = true,
              stdout = function(_, data)
                if data then
                  table.insert(stdout, data)
                end
              end,
            }, function(out)
              vim.schedule(function()
                if out.code ~= 0 then
                  vim.notify("qmd failed: " .. (out.stderr or ""), vim.log.levels.ERROR)
                  return
                end

                local raw = table.concat(stdout)
                local ok, parsed = pcall(vim.json.decode, raw)
                if not ok or type(parsed) ~= "table" or #parsed == 0 then
                  vim.notify("qmd: no results", vim.log.levels.WARN)
                  return
                end

                local collection_paths = read_collection_paths()

                fzf.fzf_exec(function(fzf_cb)
                  for _, hit in ipairs(parsed) do
                    local abs = resolve_qmd_uri(hit.file or "", collection_paths)
                    if abs then
                      local lnum, text = snippet_line_and_text(hit.snippet or "")
                      local entry = fzf.make_entry.file(abs, {
                        file_icons = true,
                        color_icons = true,
                      })
                      local score_pct = math.floor((hit.score or 0) * 100 + 0.5)
                      local line = string.format("%s:%d:1: [%d%%] %s", entry, lnum, score_pct, text)
                      fzf_cb(line)
                    end
                  end
                  fzf_cb()
                end, {
                  prompt = "qmd> ",
                  previewer = "builtin",
                  actions = fzf.defaults.actions.files,
                })
              end)
            end)
          end)
        end,
        desc = "qmd semantic search",
      },
    },
  },
}
