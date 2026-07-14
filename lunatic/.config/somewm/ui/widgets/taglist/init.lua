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
    local tag_dot = function(color, width)
        local surface = cairo.ImageSurface.create(cairo.Format.ARGB32, 32, 32)
        local cr      = cairo.Context(surface)

        cr:set_source_rgba(0, 0, 0, 0)
        cr:paint()

        local width         = width or 16
        local cw            = (32 - width) / 2

        cr:set_source(gears.color(color))
        cr:rectangle(cw, cw, width, width)
        cr:fill()
        return surface
    end    

    -- Function to update tag widget
    local update_tag = function(widget, tag, index, taglist)
        local ico       = widget:get_children_by_id('icon_role')[1]
        local width     = 10
        local color
         
        if      tag.selected then
            color = beautiful.taglist_fg_focus
            width = width * 2
        elseif  tag.urgent then
            color = beautiful.taglist_fg_urgent
        elseif  #tag:clients() > 0 then
            color = beautiful.taglist_fg_occupied
            width = width * 1.5
        else
            color = beautiful.taglist_fg_empty
        end

        ico.image       = gears.color.recolor_image(tag_dot(_, width), color)
    end

    -- @TASKLIST_BUTTON@
    -- Create a taglist widget
    return wibox.widget({
        widget  = wibox.container.background,
        -- bg      = beautiful.colors.secondary,

        awful.widget.taglist({
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
    })
    end
