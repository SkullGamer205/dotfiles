local awful = require('awful')
local wibox = require('wibox')

local module = require(... .. '.module')

return function(s)
    s.mypromptbox = module.promptbox()
    -- Create the wibox
    s.mywibox = awful.wibar({
        screen   = s,
        position = "right",
        stretch  = false,
        height   = 720,


        -- @DOC_SETUP_WIDGETS@
        widget   = {
            layout = wibox.layout.align.vertical,
            { -- Left widgets
                layout = wibox.layout.fixed.vertical,
                module.launcher(s),
                module.layoutbox(s),
                module.taglist(s),
                s.mypromptbox,
            },
            -- module.tasklist(s), -- Middle widget
                module.clock(),
            { -- Right widgets
                layout = wibox.layout.fixed.vertical,
                module.kbd_layout(),
                wibox.widget.systray(),
                module.power(s),
            },
        }
    })
end
