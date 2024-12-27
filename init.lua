require("config.lazy")
require("which-key")
local builtin = require('telescope.builtin')

require("mason").setup()
require("mason-lspconfig").setup()

require("leap").create_default_mappings()

require("mason-lspconfig").setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup {}
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	["rust_analyzer"] = function()
		require("rust-tools").setup {}
	end
}

vim.wo.number = true
vim.wo.relativenumber = true

vim.cmd.colorscheme "vscode"

vim.o.tabstop = 4
vim.o.wrap = false


-- C LSP
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'c',
	callback = function(ev)
		vim.lsp.start({
			name = 'CLang',
			cmd = { 'clangd', '--background-index' },
			root_dir = vim.fs.root(ev.buf, { 'READ_ME.txt' }),
		})
	end,
})

-- Lua LSP
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'lua',
	callback = function(ev)
		vim.lsp.start({
			name = 'Lua',
			cmd = { 'lua-language-server' },
			root_dir = vim.fs.root(ev.buf, { 'READ_ME.txt' }),
		})
	end,
})


-- Keymaps

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<C-M>", vim.lsp.buf.format, { desc = "Format current file" })

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('i', '<F9>', '<Esc>:w<CR>:term python %<CR>', { desc = "Runs current Python file in a new window" })
vim.keymap.set('n', '<F9>', ':w<CR>:term python %<CR>', { desc = "Runs current Python file in a new window" })

-- Autoinsert into Terminal

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	pattern = { "*" },
	callback = function()
		if vim.opt.buftype:get() == "terminal" then
			vim.cmd(":startinsert")
		end
	end
})
