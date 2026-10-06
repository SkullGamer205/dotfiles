local io        = io
local spawn     = require('awful.spawn')

local helpers = {}

-- Grabbed from lain
-- check if the file exists and is readable
function helpers.file_exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
end

-- get first line of a file
function helpers.first_line(path)
    local file, first = io.open(path, "rb"), nil
    if file then
        first = file:read("*l")
        file:close()
    end
    return first
end


function helpers.trim(str)
    return string.match(str, "^%s*(.-)%s*$")
end

function helpers.split(string_to_split, separator)
    if separator == nil then separator = "%s" end
    local t = {}

    for str in string.gmatch(string_to_split, "([^".. separator .."]+)") do
        table.insert(t, str)
    end

    return t
end

-- Grabbed from streetturtle/awesome-wm-widgets pactl-widget/utils.lua
function helpers.popen_return(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()

    return result
end

-- list directory contents synchronously
function helpers.list_dir(path)
    local lines = {}
    local file = io.popen("ls -1 " .. path)
    if file then
        for line in file:lines() do
            lines[#lines + 1] = line
        end
        file:close()
    end
    return lines
end

return helpers
