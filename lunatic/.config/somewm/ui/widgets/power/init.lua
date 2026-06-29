-- Power Menu
local awful         = require('awful')
local beautiful     = require('beautiful')
local gears         = require('gears')
local wibox         = require('wibox')
local SimplePopup   = require('module.simple_widgets.popup').create
local SimpleIcon    = require('module.simple_widgets.image').create_icon
local SimpleBox     = require('module.simple_widgets.box').create_box

local options = {
    {name = 'Poweroff',     icon = beautiful.power_shutdown,    key = 'p',    command = 'loginctl poweroff'},
    {name = 'Reboot',       icon = beautiful.power_reboot,      key = 'r',    command = 'loginctl reboot'},
    {name = 'Log out',      icon = beautiful.power_logout,      key = 'o',    command = 'loginctl kill-session self'},
    {name = 'Lock',         icon = beautiful.power_lockscreen,  key = 'l',    command = 'loginctl lock-session self'},
    {name = 'Suspend',      icon = beautiful.power_suspend,     key = 's',    command = 'loginctl suspend'},
    {name = 'Hibernate',    icon = beautiful.power_hibernate,   key = 'h',    command = 'loginctl hibernate'},
}

local selected_index = 1

local function create_button(option, index)
    local is_selected = index == selected_index

    local icon_widget = SimpleIcon(option.icon, {
        main_color      = beautiful.fg_normal,
        highlight_color = beautiful.bg_focus,
    })

    local text_widget = wibox.widget({
        widget = wibox.widget.textbox,
        text = '[' .. option.key .. '] ' .. option.name,
    })

    local widget = wibox.widget({
        widget   = wibox.container.margin,
        margins  = 16,
        {
            widget = wibox.layout.fixed.vertical,
            spacing = 8,
            icon_widget,
            text_widget,
        }
    })

    local button = SimpleBox(widget, {
        main_color = beautiful.bg_normal
    })

    return button
end

local function create_power_widget()
    local buttons = {}

    for i, option in pairs(options) do
        table.insert(buttons, create_button(option, i))
    end

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
                {
                    layout = wibox.layout.fixed.horizontal,
                    table.unpack(buttons),
                },
            },
        }
    })
end

local powermenu = SimplePopup('powermenu', {
    main_widget = create_power_widget,
    placement   = awful.placement.maximize,
})

return powermenu
