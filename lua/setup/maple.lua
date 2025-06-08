
require("maple").setup({
	width = 0.8,
	height = 0.8,
	border = 'none',
	winblend = 10,
	show_legend = true,

	notes_mode = project,
	use_project_specific_notes = true,

	keymaps = {
		toggle = '<leader>m',
		close = 'q',
		switch_mode = 'm',
	},
})

return {
        "forest-nvim/maple.nvim",
        config = function()
            require("maple").setup({
                    --config
            })
        end
}
