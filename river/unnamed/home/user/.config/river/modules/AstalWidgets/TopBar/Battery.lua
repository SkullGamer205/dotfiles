local astal = require("astal")
local bind = astal.bind
local Variable = require("astal").Variable
local Widget = require("astal.gtk3.widget")
local Battery = astal.require("AstalBattery")

return function()
    local bat = Battery.get_default()
    local battery_visibility = Variable()
    
    return Widget.EventBox({
        name = "Battery_EventBox",
        class_name = "battery_eventbox",
        css = "margin-right: 4px",
        on_hover = function()
             battery_visibility:set(true)
        end,


        on_hover_lost = function()
             battery_visibility:set(false)
        end,

        Widget.Box({
            name = "Battery",
            class_name = "battery",
            visible = bind(bat, "is-present"),
            Widget.Icon({
                name = "BattryIcon",
                class_name = "battery-icon",
                css = "margin-right: 4px",
                icon = bind(bat, "battery-icon-name"),
            }),
            Widget.Revealer({
                class_name = "battery-label-revealer",
                reveal_child = bind(battery_visibility),
                transition_type = "SLIDE_RIGHT",
                Widget.Label({
                    name = "BatteryLabel",
                    class_name = "battery-label",
                    label = bind(bat, "percentage"):as(
                        function(p) return tostring(math.floor(p * 100)).."%" end
                    ),
                }),
            })
        })
    })
end

