vim.lsp.config("pylsp", {
	cmd = { "uv", "run", "pylsp" },
})

vim.lsp.config("pyright", {
	cmd = { "uv", "run", "pyright-langserver", "--stdio"},
})


vim.lsp.config("ty", {
	cmd = { "uv", "run", "ty"},
})

vim.lsp.config("basedpyright", {
	cmd = { "uv", "run", "basedpyright-langserver", "--stdio"},
})

vim.lsp.config("jedi", {
	cmd = { "uv", "run", "jedi-language-server"},
})


vim.cmd [[ autocmd BufRead,BufNewFile *.scad set filetype=openscad ]]
vim.lsp.config("openscad", {
	cmd = {"openscad-lsp", "--stdio"},
	filetype = {"openscad"},
})

-- Diagnostics

vim.diagnostic.enable()
vim.diagnostic.config({
	float={
		severity_limit = vim.diagnostic.severity.ERROR,
	},
	signs=false,
	underline=false,
	virtual_lines=false,
	virtual_text=false,
	update_in_insert=true,
	severity_sort=true,
})

vim.lsp.enable("pylsp")
-- vim.lsp.enable("pyright")
-- vim.lsp.enable("ty")
vim.lsp.enable("basedpyright")
