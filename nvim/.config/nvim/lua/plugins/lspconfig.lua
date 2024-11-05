return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = false,
      },
    },
    init = function()
      -- An example nvim-lspconfig capabilities setting
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require("lspconfig")
      local on_attach = lspconfig.util.on_attach

      lspconfig.markdown_oxide.setup({
        -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
        -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
        capabilities = vim.tbl_deep_extend("force", capabilities, {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        }),
        on_attach = on_attach, -- configure your on attach config
      })
    end,
  },
}
