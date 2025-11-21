-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_augroup("lazyvim_wrap_spell", { clear = true })

local bufnr = 0

local function check_codelens_support()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, c in ipairs(clients) do
    if c.server_capabilities.codeLensProvider then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "CursorHold", "LspAttach", "BufEnter" }, {
  buffer = bufnr,
  callback = function()
    if check_codelens_support() then
      vim.lsp.codelens.refresh({ bufnr = bufnr })
    end
  end,
})
-- trigger codelens refresh
vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })

-- Disable diagnostics in kaizen directory
vim.api.nvim_create_autocmd({ "BufEnter", "LspAttach" }, {
  pattern = vim.fn.expand("~") .. "/kaizen/*",
  callback = function(ev)
    vim.diagnostic.enable(false, { bufnr = ev.buf })
  end,
})
