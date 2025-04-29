-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2,r-cr:hor20,o:hor50"
vim.opt.guicursor = vim.opt.guicursor + "a:blinkwait700-blinkoff300-blinkon250"

-- https://github.com/LazyVim/LazyVim/discussions/2150
vim.g.root_spec = { "cwd" }
