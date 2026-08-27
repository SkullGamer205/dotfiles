local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')

local module = require('ui.widgets')
local separator = require('module.simple_widgets.separator').create("horizontal",
{       color   = beautiful.colors.background_light,
        -- margins = { vertical = beautiful.useless_gap },
        width   = beautiful.border_width,
})

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
            -- margins = beautiful.gap_default,
            {
                layout = wibox.layout.align.vertical,
                expand = 'outside',
                { -- Left widgets
                    layout = wibox.layout.fixed.vertical,
                    spacing = beautiful.gap_default,
                    module.launcher(s),
                    separator,
                    module.layoutbox(s),
                    module.taglist(s),
                    separator,
                    s.mypromptbox,
                },
                -- module.tasklist(s), -- Middle widget
                {
                    layout = wibox.container.place,
                    spacing = beautiful.gap_default,
                    halign = 'center',
                    valign = 'center',
                    {
                        widget = wibox.layout.align.vertical,
                        module.music(),
                        module.clock(),
                        module.notifications(),
                    }
                },    
                { -- Right widgets
                    layout = wibox.layout.fixed.vertical,
                    spacing = beautiful.gap_default,
                    wibox.widget.systray(),
                    module.kbd(),
                    module.battery(s),
                    separator,
                    module.power(s),
                },
            }
        }
    })
end
