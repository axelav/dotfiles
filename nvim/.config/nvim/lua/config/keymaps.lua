-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--
-- flash.nvim
--
vim.keymap.set("n", "s", "s", { noremap = true })

--
-- fzf-lua
--
vim.keymap.set("n", "<leader><space>", function()
  require("fzf-lua").git_files()
end, { desc = "Git files" })

--
-- oil.nvim
--
vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", {
  silent = true,
  desc = "Open oil.nvim",
})

--
-- markdown-oxide
--
-- Helper function to check markdown-oxide LSP and execute command
local function with_markdown_oxide(cmd)
  local clients = vim.lsp.get_clients()
  local has_markdown_oxide = false

  for _, client in ipairs(clients) do
    if client.name == "markdown_oxide" then
      has_markdown_oxide = true
      break
    end
  end

  if has_markdown_oxide then
    if type(cmd) == "function" then
      cmd()
    else
      vim.cmd(cmd)
    end
  else
    vim.notify("markdown-oxide LSP is not active", vim.log.levels.WARN)
  end
end

vim.keymap.set("n", "<leader>mot", function()
  with_markdown_oxide("Today")
end, {
  silent = true,
  desc = "Open today's note",
})

vim.keymap.set("n", "<leader>mon", function()
  with_markdown_oxide("Tomorrow")
end, {
  silent = true,
  desc = "Open tomorrow's note",
})

vim.keymap.set("n", "<leader>mop", function()
  with_markdown_oxide("Yesterday")
end, {
  silent = true,
  desc = "Open yesterday's note",
})

vim.keymap.set("n", "<leader>mod", function()
  with_markdown_oxide(function()
    local timestamp = tostring(os.date("### %H:%M"))
    -- Insert the timestamp and two newlines
    local row = unpack(vim.api.nvim_win_get_cursor(0))

    vim.api.nvim_buf_set_lines(0, row, row, false, { timestamp, "", "" })

    -- Move cursor to the second newline after the timestamp
    vim.api.nvim_win_set_cursor(0, { row + 3, 0 })

    -- Enter insert mode
    vim.cmd("startinsert")
  end)
end, { desc = "Insert timestamp" })

vim.keymap.set("n", "<leader>moi", function()
  with_markdown_oxide("e pages/inbox.md")
end, {
  silent = true,
  desc = "Open inbox",
})

-- Open definition in a vertical split
-- https://news.ycombinator.com/item?id=41739452
vim.keymap.set("n", "gF", "<c-w>v<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Open definition in vsplit" })

-- Load note template
vim.keymap.set("n", "<leader>tn", function()
  local template_path = "templates/note.md"
  if vim.fn.filereadable(template_path) == 1 then
    vim.cmd("read " .. template_path)
  else
    vim.notify("Template file not found: " .. template_path, vim.log.levels.WARN)
  end
end, { desc = "Load note template" })
