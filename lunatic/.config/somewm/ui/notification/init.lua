-- Libs
local awful         = require('awful')
local beautiful     = require('beautiful')
local wibox         = require('wibox')
local naughty       = require('naughty')

local dpi           = beautiful.xresources.apply_dpi

local s_icon    = require('module.simple_widgets.image').create_icon
local separator = require('module.simple_widgets.separator').create("vertical",
{       color   = beautiful.colors.background_light,
        margin  = beautiful.useless_gap,
        width   = beautiful.border_width,
})

local _N = {}

function _N.title(n)
    return wibox.widget({
        widget  = wibox.widget.textbox,
        markup  = '<i>' .. ((n.title == nil or n.title == '') and 'SomeWM' or n.title) .. '</i>'
    })
end

function _N.body(n)
    return wibox.widget({
        widget  = wibox.widget.textbox,
        text    = n.message,
    })
end

function _N.icon(n)
    return s_icon(n.icon, {
    })
end

function _N.actions(n)
    return wibox.widget({
        widget       = naughty.list.actions,
        notification = n,
        base_layout  = wibox.widget({
            layout  = wibox.layout.flex.horizontal,
            spacing = dpi(2),
        }),
        style = {
            underline_normal    = false,
            underline_selected  = false,
            bg_normal           = beautiful.bg_focus,
        },
        widget_template = {
            widget  = wibox.container.background,
            bg      = beautiful.bg_normal,
            {
                widget  = wibox.container.margin,
                margins = dpi(4),
                widget  = wibox.container_place,
                halign  = 'center',
                {
                    widget  = wibox.widget.textbox,
                    font    = beautiful.font,
                    id      = 'text_role'
                }
            }
        }
    })
end

return function(n)
    -- local timeout = n.timeout,
    --
    -- n.timeout = 5,

    local titlebox      = wibox.widget({
        
    })

    local layout        = naughty.layout.box({
        notification    = n,
        cursor          = 'hand2',
        widget_template = {
            widget      = wibox.container.constraint,
            strategy    = 'max',
            width       = dpi(360),
            height      = dpi(320),
            {
                widget      = wibox.container.constraint,
                strategy    = 'min',
                width       = dpi(120),
                {
                    widget          = wibox.container.background,
                    bg              = beautiful.bg_normal,
                    border_width    = beautiful.border_width,
                    border_color    = beautiful.border_color_normal,
                    {
                        layout  = wibox.layout.fixed.horizontal,
                        iconbox,
                        separator,
                        {
                            laoyut = wibox.layout.fixed.vertical,
                            titlebox,
                            contentbox,
                        }
                    }
                }
            }
        }
    })

    local layout.buttons = {}

    return layout
end
