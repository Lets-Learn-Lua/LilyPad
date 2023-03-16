--[[
	TODO
	* Files need to be removed from fileCache if they are deleted
]]

---- Constants
local ARGUMENT_FUNCTIONS = {}
local HELP = [[
Usage: lilypad [COMMAND] [FLAGS]

Manages the development workflow when using the Fennel Programming Language in
Roblox Studio

COMMANDS
    start       :Watches the all the Fennel files in ./src and compiles them to Lua.
                 Places compiled files in the same directory as the target file.
FLAGS
    --version   :Shows the current build version of lilypad.
    --help      :Shows this help text.
]]

---- Variables
local fileCache = {}

---- Functions
-- Getters
local function getFennelFiles()
	return io.popen([[where /r .\\src *.fnl]])
end

local function getFileContent(path)
	local file = io.open(path, "rb")

	if file then
		local fileContent = string.gsub(file:read("*a"), "%s+", "")

		file:close()

		return fileContent
	else
		return fileCache[path]
	end
end

-- Setters
local function setFileExtension(path)
	return string.gsub(path, ".fnl", ".lua")
end

-- Booleans
local function isFileNew(path)
	if fileCache[path] then
		return false
	else
		return true
	end
end

local function isFileChanged(path)
	return fileCache[path] ~= getFileContent(path)
end

-- Actions
local function compileFile(path)
	print("Compiling File...")

	fileCache[path] = getFileContent(path)

	os.execute([[fennel --compile ]] .. path .. [[ > ]] .. setFileExtension(path))
end

local function removeFile()
	-- TODO
end

local function watchFiles()
	for path in getFennelFiles():lines() do
		if isFileNew(path) or isFileChanged(path) then
			compileFile(path)
		end
	end

	--[[
		TODO Check if file is up for removal from cache if its been deleted
	]]

	-- local startTime = os.clock()
	-- while (startTime + 3) > os.clock() do end

	os.execute([[ping -n 3 localhost > NUL]])

	return watchFiles()
end

-- Main
ARGUMENT_FUNCTIONS.start = function()
	print("Performing intial compiles...")
	coroutine.wrap(watchFiles)()
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