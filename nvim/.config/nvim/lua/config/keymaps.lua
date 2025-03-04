-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "s", "s", { noremap = true })

--
-- fzf-lua
--

vim.keymap.set("n", "<leader><space>", function()
  require("fzf-lua").git_files()
end, { desc = "Git files" })

vim.keymap.set("n", "<leader>fd", function()
  require("fzf-lua").grep({
    search = "- \\[ \\].*\\@due",
    no_esc = true,
    -- rg will be used by default
    -- cmd = "rg", -- Explicitly specify rg command
    -- rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512",
  })
end, { desc = "Search for todos with @due" })

--
-- git
--

vim.keymap.set(
  "n",
  "<leader>gb",
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  {
    silent = true,
    desc = "Open link to current line on GitHub",
  }
)

--
-- oil.nvim
--
vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", {
  silent = true,
  desc = "Open oil.nvim",
})

--
-- markdown-oxide
--

vim.keymap.set("n", "<leader>mot", "<cmd>Today<cr>", {
  silent = true,
  desc = "Open today's note",
})

vim.keymap.set("n", "<leader>mon", "<cmd>Tomorrow<cr>", {
  silent = true,
  desc = "Open tomorrow's note",
})

vim.keymap.set("n", "<leader>mop", "<cmd>Yesterday<cr>", {
  silent = true,
  desc = "Open yesterday's note",
})

-- Insert timestamp, newlines, and move cursor
vim.keymap.set("n", "<leader>mod", function()
  local timestamp = tostring(os.date("### %H:%M"))
  -- Insert the timestamp and two newlines
  local row = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_put({ timestamp, "", "" }, "l", true, true)

  -- Move cursor to the second newline after the timestamp
  vim.api.nvim_win_set_cursor(0, { row + 3, 0 })
end, { desc = "Insert timestamp, newlines, and move cursor" })

--
-- project.nvim
--

vim.keymap.set("n", "<leader>fp", function()
  local contents = require("project_nvim").get_recent_projects()
  local reverse = {}
  for i = #contents, 1, -1 do
    reverse[#reverse + 1] = contents[i]
  end
  require("fzf-lua").fzf_exec(reverse, {
    actions = {
      ["default"] = function(e)
        vim.cmd.cd(e[1])
      end,
      ["ctrl-d"] = function(x)
        local choice = vim.fn.confirm("Delete '" .. #x .. "' projects? ", "&Yes\n&No", 2)
        if choice == 1 then
          local history = require("project_nvim.utils.history")
          for _, v in ipairs(x) do
            history.delete_project(v)
          end
        end
      end,
    },
  })
end, { silent = true, desc = "Switch project" })

-- Open definition in a vertical split
-- https://news.ycombinator.com/item?id=41739452
vim.keymap.set("n", "gF", "<c-w>v<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Open definition in vsplit" })
