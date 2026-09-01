-- Libs
local wibox             = require('wibox')
local beautiful         = require('beautiful')
local SimpleBox         = require('module.simple_widgets.box').create_box

local current_time = os.time()
local day          = 24 * 60 * 60

local current_date = function(_format, _scale)
    return wibox.widget({
        widget   = wibox.widget.textbox,
        halign   = 'center',
        valign   = 'center',
        text     = os.date(_format, current_time +  day),
        font     = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match('%d+$') * _scale
    })
end

return function()
    return wibox.widget({
        widget = wibox.container.background,
        bg     = beautiful.colors.background_light,
        {
            layout  = wibox.layout.fixed.vertical,
            SimpleBox(current_date('%b | %a', 2), {
               bg_main  = beautiful.colors.foreground,
               fg_main  = beautiful.colors.background_light,
            }),
            SimpleBox(current_date('%d', 6)),
            SimpleBox(current_date('%Y', 2)),
        }
    })
end
