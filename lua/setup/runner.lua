require("lib")

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
		else
			vim.api.nvim_command("luafile %")
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


return {}
