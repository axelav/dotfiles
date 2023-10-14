return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  opts = {
    suggestion = { enabled = true },
    panel = { enabled = true },
    filetypes = {
      gitcommit = true,
      gitrebase = true,
      help = true,
      markdown = true,
      yaml = true,
    },
  },
}
