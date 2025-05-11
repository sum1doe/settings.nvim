require("config.lazy")
require("which-key")
local builtin = require('telescope.builtin')
require("mason").setup()
require("mason-lspconfig").setup()
require("maple").setup()
require("leap")
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

vim.o.tabstop = 8
vim.o.shiftwidth = 8
vim.o.expandtab = true

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
vim.keymap.set("n", "m", "<CMD>Maple<CR>", { desc = "Open maple notes" })

vim.keymap.set("n", "<C-M>", vim.lsp.buf.format, { desc = "Format current file" })
vim.keymap.set("n", "<C-S>", ":w<CR>", { desc = "Save File" })
vim.keymap.set("i", "<C-S>", "<Esc>:w<CR>a", { desc = "Save File" })

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('i', '<F7>', '<Esc>:w<CR><c-w>s:term gcc % -o %:r<CR>', { desc = "Compiles current C file" })
vim.keymap.set('n', '<F7>', ':w<CR><c-w>s:term gcc % -o %:r<CR>', { desc = "Compiles current C file" })

vim.keymap.set('i', '<F8>', '<Esc>:w<CR><c-w>s:term ./%:r<CR>', { desc = "Runs current C file" })
vim.keymap.set('n', '<F8>', ':w<CR><c-w>s:term ./%:r<CR>', { desc = "Runs current C file" })

vim.keymap.set('i', '<F9>', '<Esc>:w<CR><c-w>s:term python %<CR>', { desc = "Runs current Python file in a new window" })
vim.keymap.set('n', '<F9>', ':w<CR><c-w>s:term python %<CR>', { desc = "Runs current Python file in a new window" })

-- Leap Keymaps

vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")

-- Autoinsert into Terminal

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
        pattern = { "*" },
        callback = function()
                if vim.opt.buftype:get() == "terminal" then
                        vim.cmd(":startinsert")
                end
        end
})

-- Highlight Yank
require('tiny-glimmer').setup()
