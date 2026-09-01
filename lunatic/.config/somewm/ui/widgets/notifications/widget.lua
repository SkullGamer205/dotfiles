-- Libs
local awful             = require('awful')
local beautiful         = require('beautiful')
local wibox             = require('wibox')
local naughty           = require('naughty')

local SimpleBox         = require('module.simple_widgets.box').create_box
local SimpleIcon        = require('module.simple_widgets.image').create_icon

return function()
    local notif_count   = wibox.widget({
        widget  = wibox.widget.textbox,
        valign  = "center",
        halign  = "center",
        text    = "Notifications: " .. #naughty.list.notifications,
    })

    local clean_button  = SimpleBox(
        SimpleIcon(beautiful.battery_volt,{
            main_color      = beautiful.colors.high,
            highlight_color = beautiful.bg_normal,
        }), {
            bg_main     = beautiful.colors.background_light,
            bg_hover    = beautiful.colors.high,
            width       = beautiful.font:match("%d+$") * 2,
            on_clicked  = {
                left = function()
                naughty.notification_list:reset()
                naighty.destroy_all_notifications()
            end }
        }
    )

    local header = wibox.widget({
        widget  = wibox.container.margin,
        margins = 2,
        {
            layout  = wibox.layout.align.horizontal,
            notif_count,
            -- nil,
            clean_button,
        },
    })

    local notif_list    = wibox.widget({
        widget  = wibox.container.margin,
        margins = 2,
        {
            layout  = wibox.layout.align.vertical,
            -- naughty.notification_list,
            naughty.list.notifications,
        },
    })

    return wibox.widget({
        widget          = wibox.container.background,
        bg              = beautiful.bg_normal,
        border_color    = beautiful.border_color_active,
        border_width    = beautiful.border_width,
        {
            widget  = wibox.container.margin,
            margins = 2,
            {
                layout  = wibox.layout.align.vertical,
                header,
                notif_list,
            },
        },
    }) 
end
