vim.keymap.set('n', '<leader>h', '<cmd>HauntTerm -t NVim<cr>', {desc="Open Haunt Term"})
vim.keymap.set('t', '<leader>h', '<C-\\><C-n><cmd>q<cr>', {desc="Close current (Haunt) Terminal page."})
vim.keymap.set('t', '<cr><cr>', '<C-\\><C-n><cmd>q<cr>', {desc="Close current (Haunt) Terminal page."})
