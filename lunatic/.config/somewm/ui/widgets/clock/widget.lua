-- Libs
local awful             = require('awful')
local beautiful         = require('beautiful')
local wibox             = require('wibox')
local SimpleBox         = require('module.simple_widgets.box').create_box

local modules           = require('ui.widgets.clock.modules')

return function()
    return wibox.widget({
        widget          = wibox.container.background,
        bg              = beautiful.bg_normal,
        border_color    = beautiful.border_color_active,
        border_width    = beautiful.border_width,
        {
            layout  = wibox.layout.fixed.horizontal,
            -- Clock
            modules.clock('%H\n%M\n%S'),
            modules.calendar(),
            -- Weather
            -- {},
        }
    })
end
