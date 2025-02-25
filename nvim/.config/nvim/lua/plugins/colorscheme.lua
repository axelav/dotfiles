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
}
