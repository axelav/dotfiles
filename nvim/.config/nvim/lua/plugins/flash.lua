return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = true,
      },
    },
  },
  keys = {
    -- Disable the 's' key mapping
    s = false,
    -- Use 'f' for flash instead
    f = true,
    -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
}
