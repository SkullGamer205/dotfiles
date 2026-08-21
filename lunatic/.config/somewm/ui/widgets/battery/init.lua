local awful             = require("awful")
local wibox             = require("wibox")
local beautiful         = require("beautiful")

local SimpleIcon        = require("module.simple_widgets.image")
local SimpleBox         = require("module.simple_widgets.box")
local BatteryWidget     = require(... .. ".widget")

local icon = SimpleIcon.create_icon(beautiful.battery_full)

local widget = SimpleBox.create_box(icon, {
    main_color      = beautiful.colors_background_light,
    highlight_color = beautiful.bg_focus,
    on_clicked      = function() BatteryWidget.toggle() end
})

return function()
    return widget
end
