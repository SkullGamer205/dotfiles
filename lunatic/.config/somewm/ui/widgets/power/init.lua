-- Power Menu
local awful         = require('awful')
local beautiful     = require('beautiful')
local gears         = require('gears')
local wibox         = require('wibox')
local SimplePopup   = require('module.simple_widgets.smpl_popup')

local options = {
    {name = 'Poweroff',     icon = beautiful.power_shutdown,    key = 'p',    command = 'loginctl poweroff'},
    {name = 'Reboot',       icon = beautiful.power_reboot,      key = 'r',    command = 'loginctl reboot'},
    {name = 'Log out',      icon = beautiful.power_logout,      key = 'o',    command = 'loginctl kill-session self'},
    {name = 'Lock',         icon = beautiful.power_lockscreen,  key = 'l',    command = 'loginctl lock-session self'},
    {name = 'Suspend',      icon = beautiful.power_suspend,     key = 's',    command = 'loginctl suspend'},
    {name = 'Hibernate',    icon = beautiful.power_hibernate,   key = 'h',    command = 'loginctl hibernate'},
}

local function create_power_widget()
    return wibox.widget({
        widget  = wibox.container.background,
        {
            widget  = wibox.container.place,
            halign  = 'center',
            valign  = 'center',
            {
                layout  = wibox.layout.fixed.vertical,
                spacing = 32,
                -- Title
                {
                    widget  = wibox.widget.textbox,
                    halign  = 'center',
                    text    = 'Hello World',
                },
            },
        }
    })
end

local powermenu = SimplePopup.create('powermenu', {
    main_widget = create_power_widget,
    placement   = awful.placement.maximize,
})

return powermenu
