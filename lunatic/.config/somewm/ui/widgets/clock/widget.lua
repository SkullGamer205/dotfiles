-- Libs
local awful             = require('awful')
local beautiful         = require('beautiful')
local wibox             = require('wibox')
local gears             = require('gears')
local SimplePopup       = require('module.simple_widgets.popup').create
local SimpleBox         = require('module.simple_widgets.box').create_box

local modules           = require('ui.widgets.clock.modules')

local function create_clock_widget()
    return wibox.widget({
        widget  = wibox.container.place,
        halign  = 'right',
        valign  = 'center',
        {
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
        }
    })
end

local clockmenu = SimplePopup('clockmenu', {
    main_widget = create_clock_widget,
    placement   = awful.placement.maximize,
})

return clockmenu
