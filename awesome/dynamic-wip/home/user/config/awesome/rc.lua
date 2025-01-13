--###################################################################################################################
--###################################################################################################################
--###                                                                                                             ###
--###                                                                                                             ###
--###    MMP"""""""MM                                                           M""MMM""MMM""M M"""""`'"""`YM     ###
--###    M' .mmmm  MM                                                           M  MMM  MMM  M M  mm.  mm.  M     ###
--###    M         `M dP  dP  dP .d8888b. .d8888b. .d8888b. 88d8b.d8b. .d8888b. M  MMP  MMP  M M  MMM  MMM  M     ###
--###    M  MMMMM  MM 88  88  88 88ooood8 Y8ooooo. 88'  `88 88'`88'`88 88ooood8 M  MM'  MM' .M M  MMM  MMM  M     ###
--###    M  MMMMM  MM 88.88b.88' 88.  ...       88 88.  .88 88  88  88 88.  ... M  `' . '' .MM M  MMM  MMM  M     ###
--###    M  MMMMM  MM 8888P Y8P  `88888P' `88888P' `88888P' dP  dP  dP `88888P' M  `' . '' .MM M  MMM  MMM  M     ###
--###    MMMMMMMMMMMM                                                           MMMMMMMMMMMMMM MMMMMMMMMMMMMM     ###
--###                                                                                                             ###
--###                                                                       Автор конфигурации: SkullGamer205     ###
--###################################################################################################################
--###################################################################################################################
--
--      ___|              _|_)        |                     |           
--     |      _ \  __ \  |   |  _` |  |      _ \   _` |  _` |  _ \  __| 
--     |     (   | |   | __| | (   |  |     (   | (   | (   |  __/ |    
--    \____|\___/ _|  _|_|  _|\__, | _____|\___/ \__,_|\__,_|\___|_|    
--                            |___/                                     
--
-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
local awful = require("awful")
local gears = require("gears")
pcall(require, 'luarocks.loader')

--- Error handling.
-- Notification library.
local naughty = require('naughty')
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config).
naughty.connect_signal('request::display_error', function(message, startup)
   naughty.notification({
      urgency = 'critical',
      title   = 'Oops, an error happened' .. (startup and ' during startup!' or '!'),
      message = message
   })
end)

-- Autostart
awful.spawn.with_shell(string.format("%s/.config/awesome/autostart.sh", os.getenv("HOME")))
-- Allow Awesome to automatically focus a client upon changing tags or loading.
require('awful.autofocus')
-- Enable hotkeys help widget for VIM and other apps when client with a matching 
-- name is opened:
require('awful.hotkeys_popup.keys')

-- Load the theme. In other words, defines the variables within the `beautiful`
-- table.
require('themes')


-- Load module directory
module_dir = (gears.filesystem.get_configuration_dir() .. 'module')
-- Treat all signals. Bear in mind this implies creating all tags, attaching
-- their layouts, setting client behavior and loading UI.
require('signal')

-- Set all keybinds.
require('binds')

-- Load all client rules.
require('config.rules')

