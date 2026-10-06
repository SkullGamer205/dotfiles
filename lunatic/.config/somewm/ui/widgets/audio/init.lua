-- Libs
local beautiful      = require('beautiful')
local awful          = require('awful')

local SimplifyWidgets   = require('module.simplify.widgets')
local SimpleBox         = SimplifyWidgets.box.create
local SimpleIcon        = SimplifyWidgets.icon.create
local SimplePopup       = SimplifyWidgets.popup.create
local AudioWidget       = require(... .. '.widget')

return function(s)
    local popup = SimplePopup('volumemenu', {
        main_widget   = AudioWidget,
        placement     = ( awful.placement.under_mouse + awful.placement.no_offscreen ),
        border_width  = beautiful.border_width,
        border_color  = beautiful.border_color_active,
    })

    return SimpleBox({
        -- Sink
        SimpleBox({
            SimpleIcon(beautiful.sink_volume_high, {
                main_color      = beautiful.fg_normal,
                highlight_color = beautiful.fg_focus,
            })
        }, {
            inner_margin  = 0,
            on_clicked    = { left = function() popup.toggle() end },
        }),

        -- Source
        SimpleBox({
            SimpleIcon(beautiful.source_volume_high, {
                main_color      = beautiful.fg_normal,
                highlight_color = beautiful.fg_focus,
            })
        }, {
            inner_margin  = 0,
            on_clicked    = { left = function() popup.toggle() end },
        })
    }, {
        inner_margin      = 0,
        align             = "vertical",
        bg_main           = beautiful.colors.background_light,
    })
end

