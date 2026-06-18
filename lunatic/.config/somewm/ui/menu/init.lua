local awful     = require('awful')
local beautiful = require('beautiful')

local apps = require('config.apps')
local hk_popup = require('awful.hotkeys_popup')

-- @DOC_MENU@
-- Create a launcher widget and a main menu
local menu = {}

menu.somewm = {
   { "hotkeys", function() hk_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", apps.terminal .. " -e man awesome" },
   { "edit config", apps.editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

menu.main = awful.menu({
    items = {
        { "awesome", menu.somewm, beautiful.awesome_icon },
        { "open terminal", apps.terminal }
    }
})

return menu
