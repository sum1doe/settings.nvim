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
