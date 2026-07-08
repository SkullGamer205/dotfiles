local beautiful = require('beautiful')
local wibox     = require('wibox')
local awful     = require('awful')
local gears     = require('gears')
local cairo     = require('lgi').cairo

local mod = require('binds.mod')
local modkey = mod.modkey

return function(s)
    local taglist_buttons = {
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
                                        if client.focus then
                                            client.focus:move_to_tag(t)
                                        end
                                    end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
                                        if client.focus then
                                            client.focus:toggle_tag(t)
                                        end
                                    end),
        awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
    }

    -- Tag icon
    local tag_dot = function(color)
        local surface = cairo.ImageSurface.create(cairo.Format.ARGB32, 32, 32)
        local cr      = cairo.Context(surface)

        cr:set_source_rgba(0, 0, 0, 0)
        cr:paint()

        local width, height = 32, 32
        local cx, cy        = width / 2, height / 2
        local crad          = math.min(width, height) / 3
        local start_angle   = 0
        local end_angle     = 2 * math.pi

        cr:set_source(gears.color(color))
        cr:arc(cx, cy, crad, start_angle, end_angle)
        cr:fill()
        return surface
    end    

    -- Function to update tag widget
    local update_tag = function(widget, tag, index, taglist)
        local ico       = widget:get_children_by_id('icon_role')[1]
        local dot       = tag_dot()
        local color
         
        if      tag.selected then
            color = beautiful.taglist_fg_focus
        elseif  tag.urgent then
            color = beautiful.bg_urgent
        elseif  #tag:clients() > 0 then
            color = beautiful.fg_normal
        else
            color = beautiful.taglist_bg_focus
        end

        ico.image       = gears.color.recolor_image(dot, color)
    end

    -- @TASKLIST_BUTTON@
    -- Create a taglist widget
    return awful.widget.taglist({
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        layout  = wibox.layout.fixed.vertical,
        style   = {
            shape   = gears.shape.circle,
        },

        buttons = taglist_buttons,

        widget_template = {
            widget  = wibox.container.background,
            -- id      = 'background_role',
            {
                widget  = wibox.container.margin,
                -- margins = 2,
                {
                    widget = wibox.widget.imagebox,
                    id = 'icon_role',
                },
            },
        create_callback = update_tag,
        update_callback = update_tag,
        },
    })
end
