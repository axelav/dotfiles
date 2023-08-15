return {
  {
    "ahmedkhalf/project.nvim",
    opts = {
      -- Don't calculate root dir on specific directories
      -- Ex: { "~/.cargo/*", ... }
      exclude_dirs = {
        "~/s/super/firebase-functions/*",
        "~/s/dotfiles/*",
      },
      show_hidden = true,
      silent_chdir = false,
    },
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  },
}
