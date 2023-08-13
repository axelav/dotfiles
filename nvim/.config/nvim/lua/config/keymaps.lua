-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-p>", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })

vim.keymap.set("n", "<C-f>", function()
  require("telescope.builtin").live_grep()
end, { desc = "Grep files" })
