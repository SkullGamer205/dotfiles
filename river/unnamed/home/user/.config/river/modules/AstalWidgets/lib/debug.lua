local astal = require("astal")
local GLib = astal.require("GLib")

local Debug = {}

local LOG_DIR = GLib.get_user_data_dir() .. "/astal"
local LOG_FILE = LOG_DIR .. "/debug.log"

local COLORS = {
	RED = "\27[31m",
	YELLOW = "\27[33m",
	BLUE = "\27[34m",
	GRAY = "\27[90m",
	RESET = "\27[0m",
}

Debug.LEVELS = {
	ERROR = "ERROR",
	WARN = "WARN",
	INFO = "INFO",
	DEBUG = "DEBUG",
}

local LEVEL_COLORS = {
	ERROR = COLORS.RED,
	WARN = COLORS.YELLOW,
	INFO = COLORS.BLUE,
	DEBUG = COLORS.GRAY,
}

local config = {
	log_to_file = true,
	log_to_console = false,
	max_file_size = 1024 * 1024,
	log_level = Debug.LEVELS.DEBUG,
}

if not GLib.file_test(LOG_DIR, "EXISTS") then
	astal.exec({ "mkdir", "-p", LOG_DIR })
end

local function get_timestamp()
	local now = GLib.DateTime.new_now_local()
	return now:format("%Y-%m-%d %H:%M:%S")
end

local function format_message(level, module, message, ...)
	local formatted_msg = string.format(message, ...)
	local color = LEVEL_COLORS[level] or ""
	return string.format("%s[%s] [%s] [%s] %s%s\n", color, get_timestamp(), level, module, formatted_msg, COLORS.RESET)
end

local function write_to_file(msg)
	if not config.log_to_file then
		return
	end

	local file = io.open(LOG_FILE, "a")
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

function Debug.error(module, message, ...)
	log(Debug.LEVELS.ERROR, module, message, ...)
end

function Debug.warn(module, message, ...)
	log(Debug.LEVELS.WARN, module, message, ...)
end

function Debug.info(module, message, ...)
	log(Debug.LEVELS.INFO, module, message, ...)
end

function Debug.debug(module, message, ...)
	log(Debug.LEVELS.DEBUG, module, message, ...)
end

function Debug.set_config(new_config)
	for k, v in pairs(new_config) do
		config[k] = v
	end
end

function Debug.get_config()
	return config
end

return Debug
