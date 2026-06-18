-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- @DOC_REQUIRE_SECTION@
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
-- @DOC_ERROR_HANDLING@
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)

-- Show notification if we fell back due to X11-specific patterns in user config
if awesome.x11_fallback_info then
    -- Defer notification until after startup (naughty needs event loop running)
    gears.timer.delayed_call(function()
        local info = awesome.x11_fallback_info
        local msg = string.format(
            "Your config was skipped because it contains X11-specific code that " ..
            "won't work on Wayland.\n\n" ..
            "File: %s:%d\n" ..
            "Pattern: %s\n" ..
            "Code: %s\n\n" ..
            "Suggestion: %s\n\n" ..
            "Edit your rc.lua to remove X11 dependencies, then restart somewm.",
            info.config_path or "unknown",
            info.line_number or 0,
            info.pattern or "unknown",
            info.line_content or "",
            info.suggestion or "See somewm migration guide"
        )
        naughty.notification {
            urgency = "critical",
            title   = "Config contains X11 patterns - using fallback",
            message = msg,
            timeout = 0  -- Don't auto-dismiss
        }
    end)
end
-- }}}

-- {{{ Variable definitions
-- @DOC_LOAD_THEME@
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- Initialize lockscreen (must be after beautiful.init)
require("lockscreen").init()

-- Signals
require('signal')

-- Key bindings
require('binds')

-- Rules
require('config.rules')

-- {{{ Notifications

-- }}}
