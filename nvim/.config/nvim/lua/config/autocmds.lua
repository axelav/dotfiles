-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Auto-follow file in nvim-tree when buffer changes
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    local api = require("nvim-tree.api")

    -- Get all windows
    local tree_wins = {}
    for _, win in pairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype == "NvimTree" then
        table.insert(tree_wins, win)
      end
    end

    -- Only follow if nvim-tree is open and current buffer is a file
    if #tree_wins > 0 and vim.bo.filetype ~= "NvimTree" and vim.bo.buftype == "" then
      api.tree.find_file({ focus = false, open = false })
    end
  end,
})
