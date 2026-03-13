require("lspsaga").setup({
	sign=false,
	lightbulb ={
		enabled=false,
		sign=false
	},
})

vim.keymap.set({"n","i"}, "<C-K>", ":Lspsaga peek_definition<CR>")
