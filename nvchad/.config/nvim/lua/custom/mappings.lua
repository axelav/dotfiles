local M = {}

M.time = {
	n = {
		["<leader>d"] = { ":put =strftime('%Y-%m-%d')<CR>", "Insert current time" },
		["<leader>t"] = { ":put =strftime('%H:%M')<CR>", "Insert current time" },
	},
}

return M
