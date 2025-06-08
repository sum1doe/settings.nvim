-- Various helper functions. Unsure if I NEED to run these myself but meh
require("lib")

local specs = {}

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
print(path)

local file = io.popen("ls "..path.." -1")
local a = file:read("*l")

black_list = {"init","notify","theme","vanilla","oil"}

while a ~= nil do
	name, _ = a:gsub(".lua", "")
	if not includes(black_list, name) then 
		require("setup."..name)
		--print(name)
	end
	a = file:read("*l")
end

