-- Libs
local awful             = require('awful')
local beautiful         = require('beautiful')
local wibox             = require('wibox')
local gears             = require('gears')
local SimplePopup       = require('module.simple_widgets.popup').create
local SimpleBox         = require('module.simple_widgets.box').create_box

local function clock_widget(format)
    local clock_widget = wibox.widget({
        widget  = wibox.widget.textbox,
        align   = 'center',
        valign  = 'center',
        text    = '',
        font    = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match('%d+$') * 2
    })

    local function update_func()
        clock_widget:set_text('' .. os.date(format))
    end

    gears.timer({
        timeout     = 1,
        autostart   = true,
        call_now    = true,
        callback    = update_func,
    })

    return clock_widget
end

local function create_clock_widget()
    return wibox.widget({
        widget  = wibox.container.place,
        halign  = 'right',
        valign  = 'center',
        {
            widget          = wibox.container.baclground,
            bg              = beautiful.bg_normal,
            border_color    = beautiful.border_color_active,
            border_width    = beautiful.border_width,
            {
                widget  = wibox.layout.fixed.horizontal,
                -- Clock
                {
                    SimpleBox(clock_widget('%H\n%M\n%S'))
                },
                -- Weather
                -- {},
            }
        }
    })
end

local clockmenu = SimplePopup('clockmenu', {
    main_widget = create_clock_widget,
    placement   = awful.placement.maximize,
})

return clockmenu
