--[[
	TODO
	* Files need to be removed from fileCache if they are deleted
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
do
	print("Performing intial compiles...")
	coroutine.wrap(watchFiles)()
end