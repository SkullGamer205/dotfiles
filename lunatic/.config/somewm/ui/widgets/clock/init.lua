local beautiful = require('beautiful')
local wibox     = require('wibox')
local gears     = require('gears')

local SimpleBox     = require('module.simple_widgets.box').create_box
local ClockWidget   = require(... .. '.widget')

local function Time(format)
    -- Make a simple widget
    local time_widget = wibox.widget({
        widget  = wibox.widget.textbox,
        align   = 'center',
        valign  = 'center',
        text    = '',
    })

    -- Update function
    local function update_func()
        time_widget:set_text('' .. os.date(format))
    end

    -- Timer to trigger update function
    gears.timer({
        timeout     = 1,
        autostart   = true,
        call_now    = true,
        callback    = update_func,
    })

    -- return widget
    return time_widget
end

local widget = SimpleBox(Time('%H\n%M'), {
    main_color      = beautiful.colors.secondary,
    on_clicked      = function() ClockWidget.toggle() end
})

return function()
    return widget
end
