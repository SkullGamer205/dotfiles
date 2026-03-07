local App = require("astal.gtk3").App
local Widget = require("astal.gtk3").Widget
local Anchor = require("astal.gtk3").Astal.WindowAnchor

local tags = require(... .. '.tags')
local player = require(... .. '.player')
local clock = require(... .. '.clock')
local notif = require(... .. '.notification')
local battery = require(... .. '.battery')
local wireless = require(... .. '.wireless')
local audio = require(... .. '.audio')
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
                player(),
                clock(),
                notif(),
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
