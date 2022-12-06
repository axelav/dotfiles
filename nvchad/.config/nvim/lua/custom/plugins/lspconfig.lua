local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = { "html", "cssls", "tsserver" }

vim.o.updatetime = 100
vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
