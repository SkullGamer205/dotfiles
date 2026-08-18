local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local gears     = require('gears')

-- Module for creating wibox.widget (and button functional)
-- @param w                     function    Some widget.
-- @param opts                  table       Configuration and callbacks.
-- @param opts.id               string      (optional) Widget identificator (used for modifying).
-- @param opts.width            intenger    (optional) Box width.
-- @param opts.height           intenger    (optional) Box height.
-- @param opts.margin           intenger    (optional) Size of margins (in pixels).
-- @param opts.main_color       string      (optional) Base background color.
-- @param opts.highlight_color  string      (optional) Color when mouse hovering  over an box.
-- @param opts.on_clicked       function    (optional) Function after clicking on button.
-- @param opts.on_right_clicked function    (optional) as above, but right mouse click.

-- Simple Widget
local simplebox = {}
    function simplebox.create_box(w, opts)
        opts = opts or {}
        
        -- Defaults
        local id                = opts.id               or nil
        local inner_margin      = opts.inner_margin     or 2
        local outer_margin      = opts.outer_margin     or 2
        local width             = opts.width            or nil
        local height            = opts.height           or width
        local main_color        = opts.main_color       or nil
        local highlight_color   = opts.highlight_color  or main_color
        local f_left_click      = opts.on_clicked       or nil
        local f_right_click     = opts.on_right_clicked or nil

        local widget = wibox.widget({
            widget      = wibox.container.margin,
            margins     = outer_margin,
            {
                widget          = wibox.container.background,
                shape           = gears.shape.rectangle,
                bg              = main_color,
                forced_width    = width,
                forced_height   = height,
                {
                    widget      = wibox.container.margin,
                    margins     = inner_margin,
                    w,
                },
            },
            buttons = {
                awful.button({ }, 1, f_left_click),
                awful.button({ }, 3, f_right_click),
            }
        })

        if highlight_color ~= nil then
            widget:connect_signal('mouse::enter', function(c)
                c.bg = highlight_color
            end)
            widget:connect_signal('mouse::leave', function(c)
                c.bg = main_color
            end)
        end

        return widget
    end
return simplebox
