return {
  "zbirenbaum/copilot.lua",
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
      markdown = true,
      yaml = true,
    },
  },
}
