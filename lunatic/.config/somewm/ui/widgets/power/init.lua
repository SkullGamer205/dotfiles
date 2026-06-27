-- Power Menu
local awful         = require('awful')
local beautiful     = require('beautiful')
local gears         = require('gears')
local wibox         = require('wibox')
local SimplePopup   = require('module.simple_widgets.smpl_popup')

local function power_widget()
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
            },
        }
    })
end

local powermenu = SimplePopup.create('powermenu', {
    main_widget = power_widget,
    placement   = awful.placement.maximize,
})

return powermenu
