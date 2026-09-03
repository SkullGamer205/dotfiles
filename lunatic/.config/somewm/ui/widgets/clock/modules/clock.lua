-- Libs
local wibox             = require('wibox')
local beautiful         = require('beautiful')
local gears             = require('gears')

local SimpleBox         = require('module.simple_widgets.box').create_box

return function(format)
    local clock_widget = wibox.widget({
        widget  = wibox.widget.textbox,
        halign  = 'center',
        valign  = 'center',
        text    = '',
        font    = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match('%d+$') * 4
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

    return SimpleBox(clock_widget, {
        bg_main = beautiful.colors.background_light,
    })
end
