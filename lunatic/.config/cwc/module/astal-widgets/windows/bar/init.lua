local App = require("astal.gtk3").App
local Widget = require("astal.gtk3").Widget
local Anchor = require("astal.gtk3").Astal.WindowAnchor

local launcher = require('widgets.bar.launcher')
local tags = require('widgets.bar.tags')
local player = require('widgets.bar.player')
local clock = require('widgets.bar.clock')
local notif = require('widgets.bar.notification')
local battery = require('widgets.bar.battery')
local wireless = require('widgets.bar.wireless')
local audio = require('widgets.bar.audio')
local power = require('widgets.bar.power')

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
                launcher(),
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
