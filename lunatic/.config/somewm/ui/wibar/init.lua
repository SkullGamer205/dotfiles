local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')

local module = require('ui.widgets')

return function(s)
    s.mypromptbox = module.promptbox()
    -- Create the wibox
    s.mywibox = awful.wibar({
        screen   = s,
        position = "right",
        stretch  = false,
        height   = beautiful.wibar_height,
        margins = {
            right = beautiful.useless_gap,
        },
        -- @DOC_SETUP_WIDGETS@
        widget   = {
            layout = wibox.layout.align.vertical,
            expand = 'outside',
            { -- Left widgets
                layout = wibox.layout.fixed.vertical,
                module.launcher(s),
                module.layoutbox(s),
                module.taglist(s),
                s.mypromptbox,
            },
            -- module.tasklist(s), -- Middle widget
            {
                layout = wibox.container.place,
                halign = 'center',
                valign = 'center',
                module.clock(),
            },    
            { -- Right widgets
                layout = wibox.layout.fixed.vertical,
                module.kbd(),
                wibox.widget.systray(),
                module.power(s),
            },
        }
    })
end
