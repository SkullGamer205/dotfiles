-- Libs
local wibox     = require('wibox')
local beautiful = require('beautiful')

local SimpleBox     = require('module.simplify.widgets').box.create

return function()
    local tray = wibox.widget.systray()
    tray:set_horizontal(true)
    tray:set_base_size(24)
    return SimpleBox({
        tray
    }, {
        align           = "vertical",
        bg_main         = beautiful.bg_normal,
    })
end
