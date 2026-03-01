local astal = require('astal')
-- local App = require('astal.gtk3').App
local Widget = require('astal.gtk3').Widget
local Battery = astal.require("AstalBattery")
local bind = astal.bind
-- local Variable = astal.Variable

return function()
    local bat = Battery.get_default()
    local bat_icon = Widget.Icon({
        name = "BatteryIcon",
        icon = bind(bat, "battery-icon-name"),
    })

    return Widget.Box({
        bat_icon,
    })
end
