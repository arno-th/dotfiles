-- vim.notify("Loading Lazyvim init")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		lazyrepo,
		"--branch=stable", -- latest stable release
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = "arnoth.plugins",
	change_detection = { notify = false },
	checker = {
		enabled = true, -- check for plugin updates periodically
		notify = true, -- notify on update
	},
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
    rocks = { enabled = false },
})

-- require("lazy").setup({
-- 	spec = {
-- 		-- add LazyVim and import its plugins
-- 		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
-- 		-- import/override with your plugins
-- 		{ import = "arnoth.plugins" },
-- 	},
-- 	checker = {
-- 		enabled = true, -- check for plugin updates periodically
-- 		notify = true, -- notify on update
-- 	},
-- 	performance = {
-- 		rtp = {
-- 			-- disable some rtp plugins
-- 			disabled_plugins = {
-- 				"gzip",
-- 				-- "matchit",
-- 				-- "matchparen",
-- 				-- "netrwPlugin",
-- 				"tarPlugin",
-- 				"tohtml",
-- 				"tutor",
-- 				"zipPlugin",
-- 			},
-- 		},
-- 	},
-- })
