return {
  "folke/noice.nvim",
  event = "VeryLazy",
  -- TODO: Remove this once this issue is fixed:
  -- https://github.com/yioneko/vtsls/issues/159
  opts = {
    presets = {
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    routes = {
      {
        filter = {
          event = "notify",
          find = "Request textDocument/inlayHint failed",
        },
        opts = { skip = true },
      },
    },
  },
}
