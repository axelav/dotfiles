-- Try and enable the Deno LSP when in a Deno folder, and TypeScript in a TS folder.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        denols = {
          root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
        },
        tsserver = {
          root_dir = require("lspconfig").util.root_pattern("package.json"),
          single_file_support = false,
        },
      },
    },
  },
}
