local App = require("astal.gtk3").App
local Widget = require("astal.gtk3").Widget
local Anchor = require("astal.gtk3").Astal.WindowAnchor

local clock = require(... .. '.clock')
local battery = require(... .. '.battery')
local wireless = require(... .. '.wireless')
local audio = require(... .. '.audio')
local tags = require(... .. '.tags')
local power = require(... .. '.power')

return function(gdkmonitor)
    return Widget.Window({
        name = "AstalBar",
        class_name = "bar",
        application = App,
        gdkmonitor = gdkmonitor,
        anchor = Anchor.TOP + Anchor.RIGHT + Anchor.BOTTOM,
        exclusivity = "EXCLUSIVE",

        Widget.CenterBox({
            vertical = true,
            Widget.Box({
                name = "LeftBox",
                class_name = "box-left",
                halign = "START",
                vertical = true,
                tags(),
            }),
            
            Widget.Box({
                name = "MiddleBox",
                class_name = "box-right",
                vertical = true,
                clock(),
            }),

            Widget.Box({
                name = "RightBox",
                class_name = "box-right",
                halign = "END",
                vertical = true,
                -- audio(),
                wireless(),
                battery(),
                power(),
            })
        })
    })
end
