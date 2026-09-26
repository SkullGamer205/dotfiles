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

-- run a command and execute a function on its output line by line
function helpers.line_callback(cmd, callback)
    return spawn.with_line_callback(cmd, {
        stdout = function (line)
            callback(line)
        end,
    })
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
