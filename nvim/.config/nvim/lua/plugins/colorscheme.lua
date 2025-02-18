-- Tokyo Night
-- return {
--   "folke/tokyonight.nvim",
--   opts = {
--     -- transparent = true,
--     -- styles = {
--     --   sidebars = "transparent",
--     --   floats = "transparent",
--     -- },
--     dim_inactive = true,
--   },
-- }

-- Catppuccin
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      transparent_background = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}
