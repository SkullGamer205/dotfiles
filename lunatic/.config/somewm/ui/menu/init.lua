local awful     = require('awful')
local beautiful = require('beautiful')

local apps = require('config.apps')
local hk_popup = require('awful.hotkeys_popup')
local freedesktop = require('module.freedesktop')

-- @DOC_MENU@
-- Create a launcher widget and a main menu
local menu = {}

menu.placeholder = { " ─────────── " }

menu.somewm = {
   { "Hotkeys", function() hk_popup.show_help(nil, awful.screen.focused()) end },
   { "Manual", apps.terminal .. " -e man awesome" },
   { "Edit config", apps.editor_cmd .. " " .. awesome.conffile },
   { "Restart", awesome.restart },
   { "Quit", function() awesome.quit() end },
}

menu.favorites = {
    { "Terminal"            , apps.terminal },
    { "Explorer"            , apps.fileman  },
    { "Browser"             , apps.browser  },
}

menu.customize = {
    menu.placeholder,
    { "   W. I. P "},
    menu.placeholder,
}

menu.power = {
    { "Poweroff",       function() awful.spawn('loginctl poweroff')             end },
    { "Reboot",         function() awful.spawn('loginctl reboot')               end },
    { "Log out",        function() awful.spawn('loginctl kill-session self')    end },
    { "Lock",           function() awful.spawn('loginctl losk-session self')    end },
    { "Suspend",        function() awful.spawn('loginctl suspend')              end },
    { "Hibernate",      function() awful.spawn('loginctl hibernate')            end },
}

menu.main = freedesktop.menu.build({
    sub_menu = "All Apps",
    after  = {
        { "Quick Apps"          , menu.favorites },
        menu.placeholder        ,
        { "Styles"              , menu.customize },
        { "SomeWM"              , menu.somewm, beautiful.awesome_icon },
        { "Goodbye"             , menu.power },
    },
})

return menu
