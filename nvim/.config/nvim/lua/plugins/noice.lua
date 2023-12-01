-- return {
--   {
--     "folke/noice.nvim",
--     enabled = false,
--   },
-- }

return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
}
