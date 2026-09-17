-- Libs
local wibox     = require('wibox')
local beautiful = require('beautiful')

local s_box     = require('module.simple_widgets.box').create_box

return function()
    local tray = wibox.widget.systray()
    tray:set_horizontal(true)
    tray:set_base_size(24)
    return s_box({
        tray
    }, {
        align           = "vertical",
        bg_main         = beautiful.bg_normal,
    })
end
