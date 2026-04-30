-- qmd semantic search picker.
-- Prompts for a query, runs `qmd query --json`, and feeds results to fzf-lua
-- with the builtin previewer so <CR> opens the file at the matching line.
--
-- qmd stores documents under slugged paths (lowercase, non-alphanumerics
-- replaced with hyphens), so to open the real file from a `qmd://` URI we
-- walk each collection root, slugify every filename, and look up the result
-- in that map. This is rebuilt per query (~50ms for a few thousand files).

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

          -- Mirrors qmd's "handelize": lowercase, replace non-alphanumeric
          -- runs with single hyphens, trim hyphens at segment boundaries,
          -- preserve the file extension.
          local function slugify_segment(seg, is_last)
            if is_last then
              local name, ext = seg:match("^(.+)(%.[^.]+)$")
              if not name then
                name = seg
                ext = ""
              end
              name = name:lower():gsub("[^%w%$]+", "-"):gsub("^%-+", ""):gsub("%-+$", "")
              return name .. ext:lower()
            end
            return (seg:lower():gsub("[^%w%$]+", "-"):gsub("^%-+", ""):gsub("%-+$", ""))
          end

          local function slugify_relpath(rel)
            local parts = {}
            for p in rel:gmatch("[^/]+") do
              table.insert(parts, p)
            end
            for i, p in ipairs(parts) do
              parts[i] = slugify_segment(p, i == #parts)
            end
            return table.concat(parts, "/")
          end

          local function build_slug_map(root)
            local map = {}
            local cmd = string.format(
              "find %s -type f -name '*.md' -not -path '*/.*' -not -path '*/node_modules/*' 2>/dev/null",
              vim.fn.shellescape(root)
            )
            local handle = io.popen(cmd)
            if not handle then
              return map
            end
            for line in handle:lines() do
              local rel = line:sub(#root + 2)
              map[slugify_relpath(rel)] = line
            end
            handle:close()
            return map
          end

          local function resolve_qmd_uri(uri, slug_maps, collection_paths)
            local name, rel = uri:match("^qmd://([^/]+)/(.*)$")
            if not name or not collection_paths[name] then
              return nil
            end
            if not slug_maps[name] then
              slug_maps[name] = build_slug_map(collection_paths[name])
            end
            return slug_maps[name][rel]
          end

          -- Pick the first informative line from a snippet, returning
          -- (absolute_line_in_file, display_text). Skips frontmatter
          -- delimiters and very short lines so the listing reads better
          -- than just "---" or a bare bullet.
          local function snippet_line_and_text(snippet)
            local start_line = tonumber(snippet:match("@@ %-(%d+)")) or 1
            local content = snippet:gsub("^@@[^\n]*\n", "")

            local lines = {}
            for line in (content .. "\n"):gmatch("([^\n]*)\n") do
              table.insert(lines, line)
            end

            local fallback_line, fallback_text = start_line, lines[1] or ""
            for i, line in ipairs(lines) do
              local trimmed = line:gsub("^%s+", ""):gsub("%s+$", "")
              local is_delimiter = trimmed:match("^[%-=*_]+$") ~= nil
              if not is_delimiter and #trimmed >= 4 then
                return start_line + i - 1, trimmed
              end
            end
            return fallback_line, fallback_text
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
                local slug_maps = {}
                local skipped = 0

                fzf.fzf_exec(function(fzf_cb)
                  for _, hit in ipairs(parsed) do
                    local abs = resolve_qmd_uri(hit.file or "", slug_maps, collection_paths)
                    if abs then
                      local lnum, text = snippet_line_and_text(hit.snippet or "")
                      local entry = fzf.make_entry.file(abs, {
                        file_icons = true,
                        color_icons = true,
                      })
                      local score_pct = math.floor((hit.score or 0) * 100 + 0.5)
                      local line = string.format("%s:%d:1: [%d%%] %s", entry, lnum, score_pct, text)
                      fzf_cb(line)
                    else
                      skipped = skipped + 1
                    end
                  end
                  fzf_cb()
                  if skipped > 0 then
                    vim.schedule(function()
                      vim.notify(string.format("qmd: skipped %d unresolved result(s)", skipped), vim.log.levels.WARN)
                    end)
                  end
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
