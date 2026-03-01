local App = require("astal.gtk3").App
local Widget = require("astal.gtk3").Widget
local Anchor = require("astal.gtk3").Astal.WindowAnchor

local clock = require(... .. '.clock')
local battery = require(... .. '.battery')

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
            }),
            
            Widget.Box({
                name = "MiddleBox",
                class_name = "box-right",
                clock(),
            }),

            Widget.Box({
                name = "RightBox",
                class_name = "box-right",
                halign = "END",
                battery(),
            })
        })
    })
end
