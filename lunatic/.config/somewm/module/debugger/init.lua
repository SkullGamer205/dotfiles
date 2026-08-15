-- Default libraries
local gfs = require('gears.filesystem')

-- Main function
local Debugger = {}

--- Prints custom debug messages into console and file.
--@param module                 string      Module name
--@param message                string      Log message
--@param config                 table       Configuration values
--@param config.log_to_file     boolean     Toggle logging to file
--@param config.log_to_console  boolean     Toggle logging to console
--@param config.max_file_size   intenger    Max log file size
--@param config.log_level       string      Level of debugging

local LOG_DIR   = gfs.get_xdg_data_home() .. "/somewm" 
local LOG_FILE  = LOG_DIR .. "/somewm_log" .. os.date("%Y_%m_%d_%H_%M_%S") .. ".txt"

local COLORS    = {
    RED     = "\27[31m",
    YELLOW  = "\27[33m",
    BLUE    = "\27[34m",
    GRAY    = "\27[90m",
    RESET   = "\27[0m",
}

Debugger.LEVELS = {
    ERROR   = "ERROR",
    WARN    = "WARN",
    INFO    = "INFO",
    DEBUG   = "DEBUG",
}

local LEVEL_COLORS = {
    ERROR   = COLORS.RED,
    WARN    = COLORS.YELLOW,
    INFO    = COLORS.BLUE,
    DEBUG   = COLORS.GRAY,
}

local config = {
    log_to_file     = true,
    log_to_console  = true,
    max_file_size   = 1024 * 1024,
    log_level       = Debugger.LEVELS.DEBUG,
}

-- Directory checker
if not gfs.dir_readable(LOG_DIR) then
    gfs.make_directories(LOG_DIR)
end

-- Get current time
local function timestamp()
    return os.date("%Y.%m.%d %H:%M:%S")
end

-- Print formatted message
local function format_message(level, module, message, ...)
    local formatted_msg = string.format(message, ...)
    local color         = LEVEL_COLORS[level] or ""
    return string.format("%s[%s] [%s] [%s] %s%s\n" color, timestamp(), level, module, formatted_msg, COLORS.RESET)
end

local function write_to_file(msg)
    if not config.log_to_file then
        return
    end

    local file = io.popen(LOG_FILE, "a")
    if file then
        file:write(msg)
        file:close()
    else
        io.stderr:write("Failed to open log file for writing\n")
    end
end

local function log(level, module, message, ...)
    local msg = format_message(level, module, message, ...)

    if config.log_to_console then
        io.stdout:write(msg)
        io.stdout:flush()
    end

    write_to_file(msg)
end

--- Main functions to print messages into console and/or log file.
--- Main difference are a debug level.
function Debugger.error(module, message, ...)
    log(Debugger.LEVELS.ERROR, module, message, ...)
end

function Debugger.warn(module, message, ...)
    log(Debugger.LEVELS.WARN, module, message, ...)
end

function Debugger.info(module, message, ...)
    log(Debugger.LEVELS.INFO, module, message, ...)
end

function Debugger.debug(module, message, ...)
    log(Debugger.LEVELS.DEBUG, module, message, ...)
end

--- Functions to get/set config

function Debugger.set_config(new_config)
    for k, v in pairs(new_config)  do
        config[k] = v
    end
end

function Debugger.get_config()
    return config
end

return Debugger
