---- Constants
local ARGUMENT_FUNCTIONS = {}
local HELP = [[
Usage: lilypad [COMMAND] [FLAGS]

Manages the development workflow when using the Fennel Programming Language in
Roblox Studio

COMMANDS
  start       : Watches the all the Fennel files in ./src and compiles them to Lua.
                Places compiled files in the same directory as the target file.
                Starts Rojo to begin syncing compiled Lua files to Roblox Studio.
FLAGS
  --version   : Shows the current build version of lilypad.
  --help      : Shows this help text.
]]

-- Main
ARGUMENT_FUNCTIONS["--start"] = function()
	os.execute([[lua .\\lilypad.lua & .\\..\\bin\\rojo.exe serve]])
end

ARGUMENT_FUNCTIONS["--version"] = function()
	print("LilyPad Version: 1")
	os.exit()
end

ARGUMENT_FUNCTIONS["--help"] = function()
	print(HELP)
	os.exit()
end

do
	for _, argument in pairs(arg) do
		local action = ARGUMENT_FUNCTIONS[argument]

		if action then
			action()
		end
	end
end