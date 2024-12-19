return {
  "zbirenbaum/copilot.lua",
  enabled = true,
  cmd = "Copilot",
  build = ":Copilot auth",
  opts = {
    suggestion = {
      enabled = false,
    },
    panel = {
      enabled = false,
    },
    filetypes = {
      gitcommit = true,
      gitrebase = true,
      help = true,
      markdown = false,
      yaml = true,
    },
  },
}
