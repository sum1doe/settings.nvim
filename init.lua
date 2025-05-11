require("config.lazy")
require("which-key")
local builtin = require('telescope.builtin')
require("maple").setup()
require("leap")

for k, i in pairs(require("conform").formatters) do
    -- print(k)
end

vim.wo.number = true
vim.wo.relativenumber = true

vim.cmd.colorscheme "vscode"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.o.wrap = false

-- CMDs

vim.api.nvim_create_user_command("Config", "tabf ~/.config/nvim/init.lua", {})
vim.api.nvim_create_user_command("Reload", "luafile %", {})

-- Keymaps

vim.keymap.set("n", "-", "<CMD>Oil<CR>", {desc = "Open parent directory"})
vim.keymap.set("n", "<C-M>", vim.lsp.buf.format, {desc = "Format current file"})
vim.keymap.set("n", "<C-S>", ":w<CR>", {desc = "Save File"})
vim.keymap.set("i", "<C-S>", "<Esc>:w<CR>a", {desc = "Save File"})

vim.keymap.set('n', '<leader>ff', builtin.find_files,
               {desc = 'Telescope find files'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep,
               {desc = 'Telescope live grep'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'Telescope buffers'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags,
               {desc = 'Telescope help tags'})

vim.keymap.set('i', '<F7>', '<Esc>:w<CR><c-w>s:term gcc % -o %:r<CR>',
               {desc = "Compiles current C file"})
vim.keymap.set('n', '<F7>', ':w<CR><c-w>s:term gcc % -o %:r<CR>',
               {desc = "Compiles current C file"})

vim.keymap.set('i', '<F8>', '<Esc>:w<CR><c-w>s:term ./%:r<CR>',
               {desc = "Runs current C file"})
vim.keymap.set('n', '<F8>', ':w<CR><c-w>s:term ./%:r<CR>',
               {desc = "Runs current C file"})

vim.keymap.set('i', '<F9>', '<Esc>:w<CR><c-w>s:term python %<CR>',
               {desc = "Runs current Python file in a new window"})
vim.keymap.set('n', '<F9>', ':w<CR><c-w>s:term python %<CR>',
               {desc = "Runs current Python file in a new window"})

--[[
vim.keymap.set('i', '{<leader>', '{<Esc>li ', { desc = "I want my nice things with curly brackets." })
vim.keymap.set('i', '{<$CR>', '{<CR><Tab><CR>}<Esc>k$a',
        { desc = "I want my nice things with curly brackets." })
        ]]

vim.keymap.set('n', '<Tab>', ':tabn<CR>', {desc = "Go to next tab"})
vim.keymap.set('n', '<S-Tab>', ':tabn -1<CR>', {desc = "Go to prev tab"})

-- Leap Keymaps

vim.keymap.set({"n", "x", "o"}, "s", "<Plug>(leap-forward)")
vim.keymap.set({"n", "x", "o"}, "S", "<Plug>(leap-backward)")

-- Autoinsert into Terminal


vim.api.nvim_create_autocmd({"TermOpen", "BufEnter"}, {
    pattern = {"*"},
    callback = function()
        if vim.opt.buftype:get() == "terminal" then
            vim.cmd(":startinsert")
        end
    end
})

-- Highlight Yank
require('tiny-glimmer').setup()

-- Conform for Formatting

require("conform").setup({
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
        c = {
            "clang-format"
            -- "ast-grep",
        },
        python = {"isort", "black"},
        lua = {"lua-format"}
    },
    format_on_save = function(bufnr)
        print("Formatting")
        return {timeout_ms = 500, lsp_format = "fallback"}
    end

})

require("conform").formatters.clang_format = {
    ---[[]] prepend_args = {[[--style="{IndentWidth: 4}"]]}

    ---[[
    prepend_args = function() return {[[--style="{IndentWidth: 4}"]]} end
    -- ]]
    ---[[]] prepend_args = function() return {"--style=\"{IndentWidth:4}\""} end
}

vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1,
                                                    args.line2, true)[1]
        range = {
            start = {args.line1, 0},
            ["end"] = {args.line2, end_line:len()}
        }
    end
    require("conform").format({
        async = true,
        lsp_format = "fallback",
        range = range
    })
end, {range = true})
