-- Libs
local beautiful      = require('beautiful')
local awful          = require('awful')

local simple         = 'module.simple_widgets'
local s_box          = require(simple .. '.box'  ).create_box
local s_icon         = require(simple .. '.image').create_icon
local s_popup        = require(simple .. '.popup').create
local AudioWidget    = require(... .. '.widget')

return function(s)
    local popup = s_popup('volumemenu', {
        main_widget   = AudioWidget,
        placement     = ( awful.placement.under_mouse + awful.placement.no_offscreen ),
        border_width  = beautiful.border_width,
        border_color  = beautiful.border_color_active,
    })

    return s_box({
        -- Sink
        s_box({
            s_icon(beautiful.sink_volume_high, {
                main_color      = beautiful.fg_normal,
                highlight_color = beautiful.fg_focus,
            })
        }, {
            on_clicked  = { left = function() popup.toggle() end }
        }),

        -- Source
        s_box({
            s_icon(beautiful.source_volume_high, {
                main_color      = beautiful.fg_normal,
                highlight_color = beautiful.fg_focus,
            })
        }, {
            on_clicked  = { left = function() popup.toggle() end }
        })
    }, {
        align       = "vertical",
        bg_main     = beautiful.colors.background_light,
    })
end

