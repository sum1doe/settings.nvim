vim.keymap.set({"i", "n"}, "<C-k>", vim.lsp.buf.hover, {desc="Give info about the thing you're hovering over"})
vim.keymap.set("n", "<C-M>", vim.lsp.buf.format, {desc = "Format current file"})


-- LSP Stuff
--vim.lsp.enable("ccls")
--vim.lsp.set_log_level("debug")
vim.lsp.config("ccls", {
    init_options = {
		compilationDatabaseDirectory = "build";
		index = {
			threads = 0;
		}; 
		clang = {
			excludeArgs = { "-frounding-math"} ;
		};
    }
})

return {
	"neovim/nvim-lspconfig",
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
    },
}
