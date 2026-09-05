-- Libs
local awful         = require('awful')
local beautiful     = require('beautiful')
local wibox         = require('wibox')
local naughty       = require('naughty')

local dpi           = beautiful.xresources.apply_dpi

local s_icon    = require('module.simple_widgets.image').create_icon
local s_box     = require('module.simple_widgets.box').create_box
local separator = require('module.simple_widgets.separator').create("vertical",
{       color   = beautiful.colors.background_light,
        margin  = beautiful.useless_gap,
        width   = beautiful.border_width,
})

local _N = {}

function _N.title(n)
    return wibox.widget({
        widget  = wibox.widget.textbox,
        markup  = '<i>' .. ((n.title == nil or n.title == '') and 'SomeWM' or n.title) .. '</i>',
        align   = 'center',
        valign  = 'center',
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
        widget_templage = {
            s_box({
                id      = 'text_role',
                widget  = wibox.widget.textbox,
                font    = beautiful.font,
                align   = 'center',
                valign  = 'center',
            }, {
                bg_main         = beautiful.bg_normal,
                bg_hover        = beautiful.fg_normal,
                outer_margin    = dpi(2),
            })
        }
    })
end

return function(n)
    -- local timeout = n.timeout,
    --
    -- n.timeout = 5,

    local titlebox      = s_box(
        _N.title(n), {
        bg_main = beautiful.bg_focus,
    })
    
    local iconbox       = s_box(
        _N.icon(n), { 
        width           = dpi(48),
        height          = dpi(48),
        margins         = dpi(4),
    })

    local contentbox    = s_box({
        layout  = wibox.layout.fixed.vertical,
        _N.body(n),
        {
            widget  = wibox.container.margin,
            margins = {top = dpi(4)},
            visible = #n.actions > 0,
            _N.actions(n)
        }
    }, {
        constraint_type = 'max',
        width           = dpi(280),
        height          = dpi(280),
        margins         = dpi(12),
    })
    
    local layout        = naughty.layout.box({
        notification    = n,
        type            = "notification",
        border_width    = beautiful.border_width,
        border_color    = beautiful.border_color_normal,
        widget_template = s_box({
            layout  = wibox.layout.fixed.horizontal,
            iconbox,
            separator,
            {
                layout = wibox.layout.fixed.vertical,
                titlebox,
                contentbox,
            }
        }, {
            constraint_type = 'min',
            width           = dpi(128),
            height          = dpi(16),
            bg_main     = beautiful.bg_normal,
        })
    })

    layout.buttons = {}

    return layout
end
