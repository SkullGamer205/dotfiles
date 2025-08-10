local astal = require("astal")
local App = require("astal.gtk3").App
local bind = astal.bind
local Variable = require("astal").Variable
local Widget = require("astal.gtk3.widget")
local Battery = astal.require("AstalBattery")

return function()
    local bat = Battery.get_default()
    local battery_visibility = Variable()
   
    local bat_icon = Widget.Icon({
        name = "BattryIcon",
        icon = bind(bat, "battery-icon-name"),
    })

    local bat_label = Widget.Label({
        name = "BatteryLabel",
        css = "margin-right: 2px",
        label = bind(bat, "percentage"):as(
            function(p) return tostring(math.floor(p * 100)).."%" end
        ),
    })

    return Widget.EventBox({
        name = "Battery_EventBox",
        class_name = "ebx-battery",
        -- css = "margin-right: 4px",
        on_hover = function()
             battery_visibility:set(true)
        end,

        on_hover_lost = function()
             battery_visibility:set(false)
        end,

        on_click_release = function()
            local w_battery = App:get_window("BatteryWindow")
            if w_battery then
                if not w_battery:get_visible() then
                    w_battery:show()
                else
                    w_battery:hide()
                end
            end
        end,

        Widget.Box({
            name = "Battery",
            class_name = "box-battery",
            css = "padding: 0 0.5em 0 0.5em",
            visible = bind(bat, "is-present"),
            Widget.Revealer({
                class_name = "battery-label-revealer",
                reveal_child = bind(battery_visibility),
                transition_type = "SLIDE_LEFT",
                bat_label,
            }),
            bat_icon,
        })
    })
end

