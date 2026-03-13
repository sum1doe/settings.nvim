ts = require("nvim-treesitter.configs").setup({
	ensure_installed = {"c", "lua", "python", "javascript"},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn", -- set to `false` to disable one of the mappings
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	require("nvim-treesitter.configs").setup({
		indent = {
			enable = true,
		},
	}),
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.foldcolumn = "0"

vim.opt.foldtext = ""

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
