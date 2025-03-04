-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_augroup("lazyvim_wrap_spell", { clear = true })

vim.api.nvim_create_user_command("Dashboard", "lua Snacks.dashboard()", {})

vim.api.nvim_create_user_command("Calendar", function(opts)
  -- Get calendar output
  local cal_cmd = "cal " .. (opts.args or "")
  local cal_output = vim.fn.systemlist(cal_cmd)

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, cal_output)

  -- Function to get date under cursor
  local function get_date_under_cursor()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line_num = cursor[1]
    local col_num = cursor[2]
    local line = cal_output[line_num]

    -- Get the month and year from the calendar header (first line)
    -- FIXME: I think there's some issue here when I try to do like :Calendar -3 to show the prev/next months as well
    local header = cal_output[1]
    local month, year = header:match("(%w+)%s+(%d+)")

    -- Convert month name to number
    local month_names = {
      January = 1,
      February = 2,
      March = 3,
      April = 4,
      May = 5,
      June = 6,
      July = 7,
      August = 8,
      September = 9,
      October = 10,
      November = 11,
      December = 12,
    }
    local month_num = month_names[month]

    -- Get the day number under cursor
    local day = nil
    if line then
      -- Split line into chunks of 3 characters (calendar format)
      for i = 1, #line, 3 do
        local chunk = line:sub(i, i + 2)
        local d = tonumber(chunk:match("%d+"))
        if d and col_num >= i - 1 and col_num <= i + 1 then
          day = d
          break
        end
      end
    end

    if day and month_num and year then
      -- Format date as YYYY-MM-DD
      return string.format("%04d-%02d-%02d", tonumber(year), month_num, day)
    end
    return nil
  end

  -- Function to open journal file
  local function open_journal_file()
    local date = get_date_under_cursor()
    if date then
      local journal_dir = "$HOME/kaizen"
      local file_path = vim.fn.expand(journal_dir .. "/" .. date .. ".md")

      -- Close calendar window
      vim.api.nvim_win_close(0, true)

      -- Open the file
      vim.cmd("edit " .. file_path)
    end
  end

  -- Make buffer non-modifiable
  vim.bo[buf].modifiable = false

  -- Calculate dimensions
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

  -- Add keymaps
  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", {
    noremap = true,
    silent = true,
    callback = open_journal_file,
  })

  -- Auto-close after 10 seconds
  -- vim.defer_fn(function()
  --   if vim.api.nvim_win_is_valid(win) then
  --     vim.api.nvim_win_close(win, true)
  --   end
  -- end, 10000)
end, {
  nargs = "*",
  complete = function(ArgLead, CmdLine, CursorPos)
    local options = {
      "-1",
      "-3",
      "-m",
      "-y",
      "-h",
      "-j",
      "-w",
    }
    return vim.tbl_filter(function(val)
      return val:match("^" .. ArgLead)
    end, options)
  end,
})

-- Optional: Add a keymapping for basic calendar
vim.keymap.set("n", "<leader>c", ":Calendar<CR>", { noremap = true, silent = true })
