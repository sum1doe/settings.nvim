require("config.lazy")
require("which-key")
local builtin = require('telescope.builtin')
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
require("leap")
require('haunt').setup({
		window = {
			width_frac = 0.8,
			height_frac = 0.85,
			winblend = 10,
			title_pos = "right",
		},
})

-- Debug
-- Thanks to hookenz on SO for this one.
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function get_file_extension(str)
	local pos = (str:reverse()):find("%.")
	local pos2 = (str:reverse()):find("/")
	if pos == nil then
		return ""
	elseif pos2 == nil or pos > pos2 then
		return ""
	end
	return str:sub(-pos+1, -1)
end

function get_file_name(str)
	local pos = (str:reverse()):find("/")
	if pos == nil then
		return str
	end
	return str:sub(-pos+1, -1)
end

-- Fancy output
vim.opt.termguicolors = true

-- Overriding vim.notify with fancy notify if fancy notify exists
local notify = require("notify")
vim.notify = notify
print = function(...)
    local print_safe_args = {}
    local _ = { ... }
    for i = 1, #_ do
        table.insert(print_safe_args, tostring(_[i]))
    end
    notify(table.concat(print_safe_args, ' '), "info")
end
notify.setup()


-- Regular config bit.

vim.wo.number = true
vim.wo.relativenumber = true

vim.cmd.colorscheme "vscode"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.o.wrap = false

-- CMDs

vim.api.nvim_create_user_command("Config", "tabf ~/.config/nvim/init.lua", {})
vim.keymap.set("n", "<leader>c", "<cmd>Config<cr>")
vim.api.nvim_create_user_command("Reload", "luafile $MYVIMRC", {})
vim.keymap.set("n", "<leader>d","<cmd>tabf %<cr>", {desc="Duplicate current buffer"})

-- Keymaps

vim.keymap.set("n", "-", "<CMD>Oil<CR>", {desc = "Open parent directory"})
vim.keymap.set("n", "<C-M>", vim.lsp.buf.format, {desc = "Format current file"})
vim.keymap.set("n", "<C-S>", ":w<CR>", {desc = "Save File"})
vim.keymap.set("i", "<C-S>", "<Esc>:w<CR>", {desc = "Save File"})
vim.keymap.set("i", "<C-z>", "<Esc>ui", {desc = "Undo"})
vim.keymap.set("n", "<C-z>", "u", {desc = "Undo"})
vim.keymap.set("i", "<C-y>", "<Esc><C-r>i", {desc = "Undo"})
vim.keymap.set("n", "<C-y>", "<C-r>", {desc = "Undo"})

vim.keymap.set({"i", "n"}, "<C-k>", vim.lsp.buf.hover, {desc="Give info about the thing you're hovering over"})

vim.keymap.set('n', '<leader>n', ':noh<cr>', {desc='Make highlights go away'})

vim.keymap.set('n', '<leader>ff', builtin.find_files,
               {desc = 'Telescope find files'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep,
               {desc = 'Telescope live grep'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'Telescope buffers'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags,
               {desc = 'Telescope help tags'})

local last_exec = os.time()

function exec_file()
	-- TODO:
	local mode = vim.api.nvim_get_mode().mode
	
	-- if in insert mode, escape to normal
	if mode == 'i' then
		vim.cmd("stopinsert")
	end

	-- save all files
	vim.api.nvim_command(":wa")
	-- If you have a better option please do replace this with it.
	
	-- Get filename and filetype from filename
	local ext =get_file_extension(vim.api.nvim_buf_get_name(0)) 


	-- Figure out filetype, and execute/compile+execute
	if os.time() - last_exec < 1 then
		print("Too Soon")
	elseif ext == "lua" then
		if (vim.api.nvim_buf_get_name(0)):find("nvim/init.lua",-13)~=nil then
			vim.api.nvim_command(":Reload")
		end
	elseif ext == "py" then
		vim.api.nvim_command(":HauntTerm python "..get_file_name(vim.api.nvim_buf_get_name(0)))
	elseif ext == "c" then
		if vim.fn.filereadable(vim.loop.cwd().."/makefile")==1 then
			vim.api.nvim_command(":HauntTerm make")
		else
			local filename = get_file_name(vim.api.nvim_buf_get_name(0))
			vim.api.nvim_command(":HauntTerm gcc "..filename.." -o "..filename:sub(1,-3))
		end
	end

	last_exec = os.time()
end

vim.keymap.set({"i","n"}, "<F9>", exec_file, {desc="Try run the current file, compiling (with make) if necessary."})
--vim.keymap.set(, "<F9>", exec_file, {desc="Try run the current file, compiling (with make) if necessary."})

vim.keymap.set('i', '<F6>', '<Esc>:w<CR><c-w>s:term make<CR>',
               {desc = "Compiles current C file"})
vim.keymap.set('n', '<F6>', ':w<CR><c-w>s:term make<CR>',
               {desc = "Compiles current C file"})
vim.keymap.set('i', '<F7>', '<Esc>:w<CR><c-w>s:term gcc % -o %:r<CR>',
               {desc = "Compiles current C file"})
vim.keymap.set('n', '<F7>', ':w<CR><c-w>s:term gcc % -o %:r<CR>',
               {desc = "Compiles current C file"})

vim.keymap.set('i', '<F8>', '<Esc>:w<CR><c-w>s:term ./%:r<CR>',
               {desc = "Runs current C file"})
vim.keymap.set('n', '<F8>', ':w<CR><c-w>s:term ./%:r<CR>',
               {desc = "Runs current C file"})

--vim.keymap.set('i', '<F9>', '<Esc>:w<CR><c-w>s<cmd>HauntTerm python %<CR>',
  --             {desc = "Runs current Python file in a new window"})
--vim.keymap.set('n', '<F9>', ':w<CR><c-w>s<cmd>HauntTerm python %<CR>',
  --             {desc = "Runs current Python file in a new window"})


vim.keymap.set('n', '<leader>h', '<cmd>HauntTerm -t NVim<cr>', {desc="Open Haunt Term"})
vim.keymap.set('t', '<leader>h', '<C-\\><C-n><cmd>q<cr>', {desc="Close current (Haunt) Terminal page."})
vim.keymap.set('t', '<cr><cr>', '<C-\\><C-n><cmd>q<cr>', {desc="Close current (Haunt) Terminal page."})

vim.keymap.set({"i","n"}, "<A-k>", "ddkkp", {desc="Swap lines up"})
vim.keymap.set({"i","n"}, "<A-j>", "ddp", {desc="Swap lines up"})

--[[
vim.keymap.set('i', '{<leader>', '{<Esc>li ', { desc = "I want my nice things with curly brackets." })
vim.keymap.set('i', '{<$CR>', '{<CR><Tab><CR>}<Esc>k$a',
        { desc = "I want my nice things with curly brackets." })
        ]]

vim.keymap.set('n', '<Tab>', ':tabn<CR>', {desc = "Go to next tab", silent=true})
vim.keymap.set('n', '<S-Tab>', ':tabn -1<CR>', {desc = "Go to prev tab", silent=true})

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
        python = {"isort", "blue"},
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
