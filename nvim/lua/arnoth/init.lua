-- vim.notify("Loading custom init file `arnoth.init`")
require("arnoth.options")
require("arnoth.remap")
require("arnoth.init_lazy")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local arnothGroup = augroup("arnoth", {})
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = arnothGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})
