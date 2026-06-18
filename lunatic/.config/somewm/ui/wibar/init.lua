local awful = require('awful')
local wibox = require('wibox')

local module = require(... .. '.module')

return function(s)
    s.mypromptbox = module.promptbox()
    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,

        -- @DOC_SETUP_WIDGETS@
        widget   = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                module.launcher(s),
                module.taglist(s),
                s.mypromptbox,
            },
            module.tasklist(s), -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                module.kbd_layout(),
                wibox.widget.systray(),
                module.clock(),
                module.layoutbox(s),
            },
        }
    }
end
