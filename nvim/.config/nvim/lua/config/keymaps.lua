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

--
-- window layout
--
-- Organize windows: left pane 2/3 width, right panes 1/3 width
vim.keymap.set("n", "<leader>we", function()
  -- Get total columns available
  local total_cols = vim.o.columns
  local main_width = math.floor(total_cols * 2 / 3)

  -- Go to the first (leftmost) window
  vim.cmd("wincmd h")

  -- Set its width to 2/3
  vim.cmd("vertical resize " .. main_width)
end, { desc = "Organize windows (2/3 left, 1/3 right)" })

--
-- Markdown tasks
--
-- Toggle checkbox: [ ] <-> [x]
vim.keymap.set("n", "<leader>mx", function()
  local line = vim.api.nvim_get_current_line()
  if line:match("%[x%]") then
    line = line:gsub("%[x%]", "[ ]", 1)
  elseif line:match("%[ %]") then
    line = line:gsub("%[ %]", "[x]", 1)
  end
  vim.api.nvim_set_current_line(line)
end, { desc = "Toggle checkbox" })

-- Create task on current line (prepend - [ ])
vim.keymap.set("n", "<leader>mtc", function()
  local line = vim.api.nvim_get_current_line()
  if not line:match("^%s*%- %[.%]") then
    -- If line already starts with "- ", replace it with "- [ ] "
    if line:match("^%s*%- ") then
      line = line:gsub("^(%s*)%- ", "%1- [ ] ")
    else
      line = line:gsub("^(%s*)", "%1- [ ] ")
    end
    vim.api.nvim_set_current_line(line)
  end
  vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], #line })
  vim.cmd("startinsert!")
end, { desc = "Create task" })

-- New task line below
vim.keymap.set("n", "<leader>mto", function()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local indent = vim.api.nvim_get_current_line():match("^%s*") or ""
  vim.api.nvim_buf_set_lines(0, row, row, false, { indent .. "- [ ] " })
  vim.api.nvim_win_set_cursor(0, { row + 1, #indent + 6 })
  vim.cmd("startinsert!")
end, { desc = "New task below" })

-- Strikethrough task: - [x] text -> - ~~text~~
vim.keymap.set("n", "<leader>mts", function()
  local line = vim.api.nvim_get_current_line()
  -- Match: optional whitespace, hyphen, space, checkbox, space, then text
  local indent, text = line:match("^(%s*%- )%[.%] (.+)$")
  if indent and text then
    vim.api.nvim_set_current_line(indent .. "~~" .. text .. "~~")
  end
end, { desc = "Strikethrough task" })
