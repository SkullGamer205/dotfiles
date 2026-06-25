local wibox     = require('wibox')
local beautiful = require('beautiful')
local gears     = require('gears')
local recolor   = gears.color.recolor_image

local M = {}

M.image = function(image, id, color, highlight_color)
    local widget = wibox.widget({
        widget = wibox.widget.imagebox,
        image  = recolor(image or nil, color or '#ffffff'),
        id     = id or nil,
        halign = 'center',
        valign = 'center',
    })

    widget:connect_signal('mouse::enter', function(c)
        c.image = recolor(image, highlight_color or color)
    end)
    widget:connect_signal('mouse::leave', function(c)
        c.image = recolor(image, color)
    end)

    return widget
end

M.square = function(w, color, highlight_color)
    local widget = wibox.widget({
        widget  = wibox.container.background,
        shape   = gears.shape.rectangle,
        {
            widget  = wibox.container.margin,
            -- margins = beautiful.wibar_height / 4,
            w,
        },
        bg  = color,
        fg  = beautiful.fg_color,
    }) 

    widget:connect_signal('mouse::enter', function(c)
        c.bg = highlight_color or color
    end)
    widget:connect_signal('mouse::leave', function(c)
        c.bg = color
    end)

    return widget
end

return M
