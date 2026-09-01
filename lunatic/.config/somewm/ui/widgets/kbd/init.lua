local wibox      = require('wibox')
local awful      = require('awful')
local beautiful  = require('beautiful')

local SimpleIcon = require('module.simple_widgets.image').create_icon
local SimpleBox  = require('module.simple_widgets.box').create_box

return function()
    -- Keyboard map indicator and switcher
    local current_kbd_layout = awful.widget.keyboardlayout()
    local icon               = SimpleIcon(beautiful.keyboard,{
        main_color           = beautiful.fg_normal,
    })

    local widget             = wibox.widget({
        layout = wibox.layout.fixed.vertical,
        icon,
        {
            widget  = wibox.container.place,
            halign  = 'center',
            valign  = 'center',
            current_kbd_layout,
        }
    })

    return SimpleBox(widget, {
        bg_main = beautiful.colors.background_light,
    })
end
