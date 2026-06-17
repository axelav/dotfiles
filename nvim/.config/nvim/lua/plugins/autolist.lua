-- autolist.nvim — auto-continue, renumber, and toggle markdown lists.
-- https://github.com/gaoDean/autolist.nvim
--
-- Replaces the hand-rolled "Auto-continue markdown lists" autocmd that used to
-- live in lua/config/autocmds.lua. Beyond continuation it also renumbers
-- ordered lists, toggles checkboxes, and recalculates indentation.
--
-- Keymaps are set buffer-local (per markdown buffer) via a FileType autocmd
-- rather than globally, so the <CR> binding doesn't clobber nvim-cmp's
-- completion-confirm in other filetypes — matching the buffer-scoped approach
-- the old autocmd used. lazy.nvim re-fires the FileType event after loading an
-- `ft`-triggered plugin, so this also applies to the buffer that triggered the
-- load.

return {
  "gaoDean/autolist.nvim",
  ft = { "markdown" },
  config = function()
    require("autolist").setup()

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown" },
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>", opts)
        vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>", opts)
        vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", opts)
        vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>", opts)
        vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", opts)
        vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>", opts)
        -- NOTE: autolist's README maps this to <C-r>, which shadows Vim's redo.
        -- Use a leader binding instead.
        vim.keymap.set("n", "<leader>mr", "<cmd>AutolistRecalculate<cr>", vim.tbl_extend("force", opts, { desc = "Recalculate list" }))
      end,
    })
  end,
}
