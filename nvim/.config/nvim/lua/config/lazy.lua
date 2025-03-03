local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Default configuration
-- https://github.com/folke/lazy.nvim#️-configuration
require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.coding.copilot" },
    { import = "lazyvim.plugins.extras.coding.yanky" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    -- { import = "lazyvim.plugins.extras.util.project" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { "shortcuts/no-neck-pain.nvim", version = "*" },

    -- Colorscheme
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      opts = {
        dim_inactive = {
          enabled = true,
          percentage = 0.15,
        },
        transparent_background = true,
        custom_highlights = function(colors)
          return {
            Cursor = { bg = colors.surface2, fg = colors.base },
          }
        end,
      },
    },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "catppuccin-macchiato",
      },
    },

    -- Plugins
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        indent = {
          enable = true,
        },
      },
    },
    {
      "ruifm/gitlinker.nvim",
      lazy = true,
      init = function()
        require("gitlinker").setup()
      end,
    },
    {
      "utilyre/barbecue.nvim",
      dependencies = {
        "SmiteshP/nvim-navic",
      },
      config = true,
    },
    {
      "stevearc/oil.nvim",
      opts = {},
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      lazy = false,
    },

    -- Disabled plugins
    {
      "akinsho/bufferline.nvim",
      enabled = false,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      enabled = false,
    },

    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    version = nil, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  checker = {
    enabled = true,
    notify = false,
    frequency = 3600,
  },
  ui = {
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
