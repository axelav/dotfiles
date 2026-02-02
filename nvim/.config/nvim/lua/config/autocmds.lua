-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable the default LazyVim autocmd that enables wrap and spell for markdown files
-- vim.api.nvim_create_augroup("lazyvim_wrap_spell", { clear = true })

local function check_codelens_support(buf)
  local clients = vim.lsp.get_clients({ bufnr = buf })
  for _, c in ipairs(clients) do
    if c.server_capabilities.codeLensProvider then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "CursorHold", "LspAttach", "BufEnter" }, {
  pattern = "*.md",
  callback = function(ev)
    if check_codelens_support(ev.buf) then
      vim.lsp.codelens.refresh({ bufnr = ev.buf })
    end
  end,
})

-- Disable diagnostics for all markdown files
vim.api.nvim_create_autocmd({ "BufEnter", "LspAttach" }, {
  pattern = "*.md",
  callback = function(ev)
    vim.diagnostic.enable(false, { bufnr = ev.buf })
  end,
})

-- Disable capital spell checking in markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.spellcapcheck = ""
  end,
})

-- Automatically wrap bare URLs in angle brackets in markdown files before saving
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.md",
  callback = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local changed = false

    for i, line in ipairs(lines) do
      local new_line = line:gsub("([%s^])(https?://[%w%-_%.%?%/%+=&#%%]+)([%s$])", "%1<%2>%3")
      if new_line ~= line then
        lines[i] = new_line
        changed = true
      end
    end

    if changed then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      vim.api.nvim_win_set_cursor(0, cursor)
    end
  end,
})
