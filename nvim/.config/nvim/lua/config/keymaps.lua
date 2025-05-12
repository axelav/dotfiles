-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- flash.nvim
vim.keymap.set("n", "s", "s", { noremap = true })

-- fzf-lua
vim.keymap.set("n", "<leader><space>", function()
  require("fzf-lua").git_files()
end, { desc = "Git files" })

-- oil.nvim
vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", {
  silent = true,
  desc = "Open oil.nvim",
})

-- markdown-oxide
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

vim.keymap.set("n", "<leader>moi", function()
  -- Let Neovim handle finding or creating the buffer
  -- :e will switch to the buffer if it exists, or open it if it doesn't
  vim.cmd("e pages/inbox.md")
end, {
  silent = true,
  desc = "Open inbox",
})

-- Open definition in a vertical split
-- https://news.ycombinator.com/item?id=41739452
vim.keymap.set("n", "gF", "<c-w>v<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Open definition in vsplit" })
