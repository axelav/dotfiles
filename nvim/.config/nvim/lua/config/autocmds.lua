-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_augroup("lazyvim_wrap_spell", { clear = true })

vim.api.nvim_create_user_command("Dashboard", "lua Snacks.dashboard()", {})

vim.api.nvim_create_user_command("Calendar", function(opts)
  -- Get calendar output with any passed arguments
  local cal_cmd = "cal " .. (opts.args or "")
  local cal_output = vim.fn.systemlist(cal_cmd)

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, cal_output)

  -- Make buffer non-modifiable
  vim.bo[buf].modifiable = false

  -- Calculate dimensions (adjust width based on output)
  local width = 0
  for _, line in ipairs(cal_output) do
    width = math.max(width, #line)
  end
  local height = #cal_output

  -- Get editor dimensions
  local ui = vim.api.nvim_list_uis()[1]
  local row = math.floor((ui.height - height) / 2)
  local col = math.floor((ui.width - width) / 2)

  -- Window options
  local win_opts = {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
  }

  -- Create window
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  -- Add keymaps for closing
  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":close<CR>", { noremap = true, silent = true })

  -- Auto-close after 10 seconds
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, 10000)
end, {
  nargs = "*", -- Allow any number of arguments
  complete = function(ArgLead, CmdLine, CursorPos)
    -- Basic completion for common cal options
    local options = {
      "-1",
      "-3",
      "-m",
      "-y",
      "-h",
      "--help",
      "-j",
      "-s",
      "-w",
      "-b",
    }
    return vim.tbl_filter(function(val)
      return val:match("^" .. ArgLead)
    end, options)
  end,
})

-- Optional: Add a keymapping for basic calendar
vim.keymap.set("n", "<leader>c", ":Calendar<CR>", { noremap = true, silent = true })
