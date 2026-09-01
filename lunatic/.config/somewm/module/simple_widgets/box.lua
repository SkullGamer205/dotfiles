local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local gears     = require('gears')

-- Module for creating wibox.widget (and button functional)
-- @param w                         function    Some widget.
-- @param opts                      table       Configuration and callbacks.
-- @param opts.id                   string      (optional) Widget identificator (used for modifying).
-- @param opts.width                intenger    (optional) Box width.
-- @param opts.height               intenger    (optional) Box height.
-- @param opts.margin               intenger    (optional) Size of margins (in pixels).
-- @param opts.bg_main              string      (optional) Base background color.
-- @param opts.bg_hover             string      (optional) Color when mouse hovering  over an box.
-- @param opts.fg_main              string      (optional) Base foreground color.
-- @param opts.fg_hover             string      (optional) Foreground color when mouse hovering  over an box.
-- @param opts.on_clicked           table       (optional) Function after clicking on button.
-- @param opts.on_clicked.left      function    (optional) Function after clicking on left mouse click.
-- @param opts.on_clicked.middke    function    (optional) Function after clicking on middle mouse click.
-- @param opts.on_clicked.right     function    (optional) Function after clicking on right mouse click.

-- Simple Widget
local simplebox = {}
    function simplebox.create_box(w, opts)
        opts                    = opts                  or {}
        opts.on_clicked         = opts.on_clicked       or {}
        

        -- Defaults
        local id                = opts.id                   or nil
        local inner_margin      = opts.inner_margin         or 2
        local outer_margin      = opts.outer_margin         or 2
        local width             = opts.width                or nil
        local height            = opts.height               or width
        
        -- Background
        local bg_main           = opts.bg_main              or nil
        local bg_hover          = opts.bg_hover             or bg_main

        -- Foreground
        local fg_main           = opts.fg_main  or opts.bg_hover    or nil
        local fg_hover          = opts.fg_hover or opts.bg_main     or nil

        -- Actions
        local action_left       = opts.on_clicked.left      or nil
        local action_middle     = opts.on_clicked.middle    or nil
        local action_right      = opts.on_clicked.right     or nil

        local widget = wibox.widget({
            widget      = wibox.container.margin,
            margins     = outer_margin,
            {
                widget          = wibox.container.background,
                shape           = gears.shape.rectangle,
                bg              = bg_main,
                fg              = fg_main,
                forced_width    = width,
                forced_height   = height,
                {
                    widget      = wibox.container.margin,
                    margins     = inner_margin,
                    w,
                },
            },
            buttons = {
                awful.button({ }, 1, action_left),
                awful.button({ }, 2, action_middle),
                awful.button({ }, 3, action_right),
            }
        })

        if highlight       ~= nil then
            widget:connect_signal('mouse::enter', function(c)
                c.bg = bg_hover      
                c.fg = fg_hover      
            end)
            widget:connect_signal('mouse::leave', function(c)
                c.bg = bg_main      
                c.fg = fg_main      
            end)
        end

        return widget
    end
return simplebox
