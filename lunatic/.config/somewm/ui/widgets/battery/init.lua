local awful             = require("awful")
local wibox             = require("wibox")
local beautiful         = require("beautiful")

local SimpleIcon        = require("module.simple_widgets.image")
local SimpleBox         = require("module.simple_widgets.box")
local SimplePopup       = require('module.simple_widgets.popup').create
local BatteryWidget     = require(... .. ".widget")

return function(s)

    local popup = SimplePopup('batterymenu', {
        main_widget = BatteryWidget,
        placement   = (awful.placement.under_mouse + awful.placement.no_offscreen ),
    })
    
    local icon = SimpleIcon.create_icon(beautiful.battery_full)
    
    local widget = SimpleBox.create_box(icon, {
        bg_main     = beautiful.colors.background_light,
        bg_hover    = beautiful.bg_focus,
        on_clicked  = { left = function() popup.toggle() end }
    })
    
    return widget
end
