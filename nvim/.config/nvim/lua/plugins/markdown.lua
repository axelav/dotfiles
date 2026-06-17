-- rumdl as the markdown linter + formatter (https://github.com/rvben/rumdl).
--
-- Replaces the prettier / markdownlint-cli2 / markdown-toc pipeline that the
-- LazyVim `lang.markdown` and `formatting.prettier` extras set up for markdown:
--   * conform formats with `rumdl fmt`
--   * rumdl's LSP server provides diagnostics + code actions
--
-- The LazyVim extras append to the list-style `formatters_by_ft` / `linters_by_ft`
-- entries, so we use function-form opts to hard-replace them rather than merge
-- (a plain table would leave prettier/markdownlint in the list, fighting rumdl).
-- rumdl is installed via mise and resolved on PATH.

return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}
      -- `--silent` guarantees stdout carries only formatted markdown.
      opts.formatters.rumdl = { args = { "fmt", "--silent", "-" } }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft["markdown"] = { "rumdl" }
      opts.formatters_by_ft["markdown.mdx"] = { "rumdl" }
    end,
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      -- Diagnostics now come from rumdl's LSP, not markdownlint-cli2.
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft["markdown"] = {}
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Uses nvim-lspconfig's shipped lsp/rumdl.lua (`rumdl server`).
        rumdl = {},
      },
    },
  },
}
