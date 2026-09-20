-- Libs
local beautiful = require('beautiful')
local awful     = require('awful')

local SimplifyWidgets   = require('module.simplify.widgets')
local SimpleBox         = SimplifyWidgets.box.create
local SimpleIcon        = SimplifyWidgets.icon.create
local SimplePopup       = SimplifyWidgets.popup.create
local TrayWidget  = require(... .. '.widget')

return function(s)
    local popup = SimplePopup('traymenu', {
        main_widget   = TrayWidget,
        placement     = ( awful.placement.under_mouse + awful.placement.no_offscreen ),
        border_width  = beautiful.border_width,
        border_color  = beautiful.border_color_active,
    })

    return SimpleBox({
        SimpleIcon(beautiful.systray_icon, {
            main_color      = beautiful.fg_normal,
            highlight_color = beautiful.fg_focus,
        })
    }, {
        bg_main     = beautiful.colors.background_light,
        on_clicked  = { left = function() popup.toggle() end }
    })
end
