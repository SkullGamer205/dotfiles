-- Default libraires
local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local gears     = require('gears')

-- Module for creating & modifing images or icons
-- @param image                 string      Path to icon or beautiful.<icon_name> argument.
-- @param opts                  table       Configuration and callbacks.
-- @param opts.id               string      Image identificator (used for modifying).
-- @param opts.main_color       string      (optional) Base icon color (for SVG or transparent image).
-- @param opts.highlight_color  string      (optional) Color when mouse hovering  over an icon.

-- Simple Icon
local simpleicon = {}

    function simpleicon.create_icon(image, opts)
        opts = opts or {}

        -- Defaults
        local id                = opts.id               or nil
        local main_color        = opts.main_color       or nil
        local highlight_color   = opts.highlight_color  or main_color

        local function recolor(image, color)
            if color == nil then return image end

            return gears.color.recolor_image(image, color)
        end

        local widget = wibox.widget({
            widget  = wibox.widget.imagebox,
            id      = id,
            image   = recolor(image, main_color),
            halign  = 'center',
            valign  = 'center',
            resize  = true,
            upscale = true
        })

        if highlight_color ~= nil then
            widget:connect_signal('mouse::enter', function(c)
                c.image = recolor(image, highlight_color)
            end)
            widget:connect_signal('mouse::leave', function(c)
                c.image = recolor(image, main_color)
            end)
        end

        return widget
    end

return simpleicon
