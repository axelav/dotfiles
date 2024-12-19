-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader><space>", function()
  require("telescope.builtin").git_files()
  require("fzf-lua").git_files()
end, { desc = "Git files" })

-- vim.keymap.del("t", "<C-->")
-- vim.keymap.del("t", "<C-/>")

vim.keymap.set(
  "n",
  "<leader>gb",
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  {
    silent = true,
    desc = "Open link to current line on GitHub",
  }
)

-- Open definition in a vertical split
-- https://news.ycombinator.com/item?id=41739452
vim.keymap.set("n", "gF", "<c-w>v<cmd>lua vim.lsp.buf.definition()<CR>")

-- Insert timestamp, newlines, and move cursor
vim.keymap.set("n", "<leader>T", function()
  local timestamp = tostring(os.date("### %H:%M"))
  -- Insert the timestamp and two newlines
  local row = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_put({ timestamp, "", "" }, "l", true, true)

  -- Move cursor to the second newline after the timestamp
  vim.api.nvim_win_set_cursor(0, { row + 3, 0 })
end, { desc = "Insert timestamp, newlines, and move cursor" })

-- Toggle the nvim-tree file explorer with <leader>e
vim.keymap.set("n", "<leader>e", function()
  local nvim_tree_api = require("nvim-tree.api")
  local tree_wins = {}

  -- Find all NvimTree windows
  for _, win in pairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "NvimTree" then
      table.insert(tree_wins, win)
    end
  end

  if #tree_wins > 0 then
    -- NvimTree is open, so toggle it closed
    nvim_tree_api.tree.toggle()
  else
    -- NvimTree is closed, so find current file
    nvim_tree_api.tree.find_file({ open = true, focus = true })
  end
end, { desc = "Toggle NvimTree or Find File" })

vim.keymap.set("n", "<leader>mot", "<cmd>Today<cr>", {
  silent = true,
  desc = "Open today's note",
})

-- Toggle NoNeckPain
-- vim.keymap.set("n", "<leader>np", ":NoNeckPain<CR>", {
--   desc = "Toggle NoNeckPain",
--   silent = true,
-- })

vim.keymap.set("n", "<leader>fp", function()
  local contents = require("project_nvim").get_recent_projects()
  local reverse = {}
  for i = #contents, 1, -1 do
    reverse[#reverse + 1] = contents[i]
  end
  require("fzf-lua").fzf_exec(reverse, {
    actions = {
      ["default"] = function(e)
        vim.cmd.cd(e[1])
      end,
      ["ctrl-d"] = function(x)
        local choice = vim.fn.confirm("Delete '" .. #x .. "' projects? ", "&Yes\n&No", 2)
        if choice == 1 then
          local history = require("project_nvim.utils.history")
          for _, v in ipairs(x) do
            history.delete_project(v)
          end
        end
      end,
    },
  })
end, { silent = true, desc = "Switch project" })
