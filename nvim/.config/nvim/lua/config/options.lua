-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Override the root directory detection to use the current working directory
vim.g.root_spec = { "cwd" }

-- Set text width for formatting commands (gw, gq, etc.)
vim.opt.textwidth = 120

-- Cursor settings to fix visibility issues
vim.opt.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.termguicolors = true

-- Set cursor highlight after colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Cursor", { bg = "#f5a97f", fg = "#24273a", reverse = false })
    vim.api.nvim_set_hl(0, "lCursor", { bg = "#f5a97f", fg = "#24273a", reverse = false })
    -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#363a4f" })
    -- vim.api.nvim_set_hl(0, "Visual", { bg = "#494d64" })
  end,
})
