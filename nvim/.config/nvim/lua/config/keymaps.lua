-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader><space>", function()
  require("telescope.builtin").git_files()
end, { desc = "Git files" })

-- vim.keymap.del("t", "<C-->")
-- vim.keymap.del("t", "<C-/>")

vim.keymap.set(
  "n",
  "<leader>gb",
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  {
    silent = true,
    desc = "Open link to current line on GitHub",
  }
)

-- Open definition in a vertical split
-- https://news.ycombinator.com/item?id=41739452
vim.keymap.set("n", "gF", "<c-w>v<cmd>lua vim.lsp.buf.definition()<CR>")

-- Insert timestamp, newlines, and move cursor
vim.keymap.set("n", "<leader>T", function()
  local timestamp = tostring(os.date("### %H:%M"))
  local row = unpack(vim.api.nvim_win_get_cursor(0))

  -- Insert the timestamp and two newlines
  vim.api.nvim_put({ timestamp, "", "" }, "l", true, true)

  -- Move cursor to the second newline after the timestamp
  vim.api.nvim_win_set_cursor(0, { row + 3, 0 })
end, { desc = "Insert timestamp, newlines, and move cursor" })
