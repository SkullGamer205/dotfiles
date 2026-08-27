local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

local sprtr = {}    

function sprtr.create(direction, opts)
    opts         = opts or {}
    opts.margins = opts.margins or {}
   
    local direction = direction   or "horizontal"
    local color     = opts.color  or beautiful.bg_normal     or "#FFFFFF"
    local width     = opts.width  or beautiful.border_width  or 1
    local margin_h  = opts.margin or opts.margins.horizontal or 0
    local margin_v  = opts.margin or opts.margins.vertical   or 0

    local separator = wibox.widget({
        widget  = wibox.container.margin,
        margins = {
            top  = margin_v, bottom = margin_v,
            left = margin_h, right  = margin_h,
        },
        {
            widget  = wibox.container.background,
            bg      = color,
            forced_width  = (direction == "vertical"  ) and dpi(width) or nil,
            forced_height = (direction == "horizontal") and dpi(width) or nil,
            -- widget  = wibox.widget.separator,    
            -- color   = color,
            -- thickness = dpi(width),
            -- orientation = direction,
        }
    })

    return separator
end

return sprtr
