-- Regular config bit.

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.o.wrap = false

-- Navigation
vim.keymap.set('n', '<Tab>', ':tabn<CR>', {desc = "Go to next tab", silent=true})
vim.keymap.set('n', '<S-Tab>', ':tabn -1<CR>', {desc = "Go to prev tab", silent=true})

-- Window Navigation
vim.keymap.set('n', 'H', '<C-w>h', {desc = "Go to left window"})
vim.keymap.set('n', 'L', '<C-w>l', {desc = "Go to right window"})
vim.keymap.set('n', 'J', '<C-w>j', {desc = "Go to bottom window"})
vim.keymap.set('n', 'K', '<C-w>k', {desc = "Go to top window"})


-- Code Editing
vim.keymap.set("i", "<C-z>", "<Esc>ui", {desc = "Undo"})
vim.keymap.set("n", "<C-z>", "u", {desc = "Undo"})
vim.keymap.set("i", "<C-y>", "<Esc><C-r>i", {desc = "Undo"})
vim.keymap.set("n", "<C-y>", "<C-r>", {desc = "Undo"})

vim.keymap.set({"i","n"}, "<A-k>", ":m .-2<CR>", {desc="Swap lines up"})
vim.keymap.set({"i","n"}, "<A-j>", ":m .+1<CR>", {desc="Swap lines up"})


-- Editor
vim.api.nvim_create_user_command("Config", "tabf ~/.config/nvim/init.lua", {})
vim.keymap.set("n", "<leader>c", "<cmd>Config<cr>")
vim.api.nvim_create_user_command("Reload", "luafile $MYVIMRC", {})
vim.keymap.set("n", "<leader>d","<cmd>tabf %<cr>", {desc="Duplicate current buffer"})

vim.keymap.set('n', '<leader>n', ':noh<cr>', {desc='Make highlights go away'})

-- File Management
vim.keymap.set("n", "<C-S>", ":w<CR>", {desc = "Save File"})
vim.keymap.set("i", "<C-S>", "<Esc>:w<CR>", {desc = "Save File"})



-- Autoinsert into Terminal

vim.api.nvim_create_autocmd({"TermOpen", "BufEnter"}, {
    pattern = {"*"},
    callback = function()
        if vim.opt.buftype:get() == "terminal" then
            vim.cmd(":startinsert")
        end
    end
})


-- TODO
--[[
vim.keymap.set('i', '{<leader>', '{<Esc>li ', { desc = "I want my nice things with curly brackets." })
vim.keymap.set('i', '{<$CR>', '{<CR><Tab><CR>}<Esc>k$a',
        { desc = "I want my nice things with curly brackets." })
        ]]

--------------------------------------------

-- If you want to add a plugin, make a new .lua file with a semi-descriptive name.
-- It HAS TO end on return and return the plugin's github string w/ or w/out config.
-- Return an empty table so that lazy doesn't yell at me each and every time
return {}
