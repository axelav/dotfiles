-- copilot configuration
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "right",
      -- width = 35,
      -- relative = "editor",
      -- auto_resize = true,
      -- ignore_focused = true,
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
      },
    },
    -- panel = { enabled = true },
  },
}
