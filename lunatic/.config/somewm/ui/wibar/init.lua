local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')

local module = require('ui.widgets')

return function(s)
    s.mypromptbox = module.promptbox()
    -- Create the wibox
    s.mywibox = awful.wibar({
        screen          = s,
        position        = "right",
        stretch         = false,
        width           = beautiful.wibar_width,
        height          = beautiful.wibar_height,

        border_width    = beautiful.border_width,
        border_color    = beautiful.colors.background_light,
        margins         = {
            right       = beautiful.useless_gap,
        },
        -- @DOC_SETUP_WIDGETS@
        widget   = {
            widget  = wibox.container.margin,
            margins = beautiful.gap_default,
            {
                layout = wibox.layout.align.vertical,
                expand = 'outside',
                { -- Left widgets
                    layout = wibox.layout.fixed.vertical,
                    spacing = beautiful.gap_default,
                    module.launcher(s),
                    module.layoutbox(s),
                    module.taglist(s),
                    s.mypromptbox,
                },
                -- module.tasklist(s), -- Middle widget
                {
                    layout = wibox.container.place,
                    spacing = beautiful.gap_default,
                    halign = 'center',
                    valign = 'center',
                    module.clock(),
                },    
                { -- Right widgets
                    layout = wibox.layout.fixed.vertical,
                    spacing = beautiful.gap_default,
                    module.kbd(),
                    wibox.widget.systray(),
                    module.power(s),
                },
            }
        }
    })
end
