return {
  {
    "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
      local function make_discogs_request(query)
        local curl = require("plenary.curl")
        local encoded_query = vim.uri_encode(query)
        local url = "https://endpoints.honkytonk.in/discogs?q=" .. encoded_query

        local response = curl.get(url)

        if response.status ~= 200 then
          vim.api.nvim_err_writeln("Failed to get response from Discogs API")
          return nil
        end

        if not response.body or response.body:match("^%s*$") then
          vim.notify("No results found for: " .. query, vim.log.levels.WARN)
          return nil
        end

        local success, parsed = pcall(vim.json.decode, response.body)
        if not success then
          vim.api.nvim_err_writeln("Failed to parse JSON response")
          return nil
        end

        if not parsed or not parsed.artist or not parsed.title then
          vim.notify("No results found for: " .. query, vim.log.levels.WARN)
          return nil
        end

        return parsed
      end

      local function format_as_markdown(data)
        local lines = {
          string.format("- [[%s]], _%s_ ([[%s]])", data.artist, data.title, data.year),
          "  - rating::",
          string.format("  - record-label:: [[%s]]", data.label),
        }

        local formatted_tags = ""
        if data.tags then
          formatted_tags = table.concat(
            vim.tbl_map(function(tag)
              tag = tag:gsub("&", "and"):gsub("%s+", "-")
              return "#" .. tag
            end, data.tags),
            " "
          )
        end
        table.insert(lines, string.format("  - tags:: #albums %s", formatted_tags))

        if data.url then
          table.insert(lines, string.format("  - url:: %s", data.url))
        end

        return table.concat(lines, "\n")
      end

      function DiscogsLookup()
        local query = vim.api.nvim_get_current_line()

        local data = make_discogs_request(query)
        if not data then
          return
        end

        local markdown = format_as_markdown(data)

        local row = vim.api.nvim_win_get_cursor(0)[1]

        vim.api.nvim_buf_set_lines(0, row - 1, row, false, vim.split(markdown, "\n"))
      end

      vim.api.nvim_create_user_command("DiscogsLookup", DiscogsLookup, {})

      -- vim.keymap.set('n', '<leader>d', ':DiscogsLookup<CR>', { noremap = true, silent = true })
    end,
  },
}
