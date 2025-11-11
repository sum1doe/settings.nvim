-- Various helper functions. Calling this here is definitely necessary
require("lib")

-- Notify gets prio here due to messing with print stuff.
require("setup.notify")

-- Theme so if something breaks it isn't TOO ugly
require("setup.theme")

-- Non-plugin related keybinds
require("setup.vanilla")


-- Temp: 
require("setup.oil")
-- TODO: Include all of the things that haven't yet been done

local path = vim.fn.stdpath("config").."/lua/setup"

local file = io.popen("ls "..path.." -1")
local a = file:read("*l")

black_list = {"init","notify","theme","vanilla","oil"}

local num_loaded = 5
local num_total = 5

--print(string.find("stuff.disabled", ".disabled"))

while a ~= nil do
	name, _ = a:gsub(".lua", "")
	local ok = false
	-- Check if the current file has been disabled and skip it
	if string.find(name, ".disabled") then 
		--print(name.." has been skipped for loading")
		goto finally
	end

	if includes(black_list, name) then
		goto finally
	end

	num_total = num_total + 1

	ok, module = pcall(require, ("setup."..name))
	if ok then
		num_loaded = num_loaded + 1
	else
		print("setup."..name.." had a problem while loading")
	end

	::finally::
	a = file:read("*l")
end
print("("..num_loaded.."/"..num_total..") Setups loaded")

