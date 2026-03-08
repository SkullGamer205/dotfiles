local App = require("astal.gtk3").App
local Widget = require("astal.gtk3").Widget
local Anchor = require("astal.gtk3").Astal.WindowAnchor

local widgetsDir = 'widgets.bar'
local launcher   = require(widgetsDir .. '.launcher')
local tags       = require(widgetsDir .. '.tags')
local player     = require(widgetsDir .. '.player')
local clock      = require(widgetsDir .. '.clock')
local notif      = require(widgetsDir .. '.notification')
local xkb        = require(widgetsDir .. '.xkb')
local wireless   = require(widgetsDir .. '.wireless')
local audio      = require(widgetsDir .. '.audio')
local battery    = require(widgetsDir .. '.battery')
local power      = require(widgetsDir .. '.power')

return function(gdkmonitor)
    return Widget.Window({
        name = "AstalBar",
        class_name = "bar",
        application = App,
        gdkmonitor = gdkmonitor,
        anchor = Anchor.TOP + Anchor.RIGHT + Anchor.BOTTOM,
        exclusivity = "EXCLUSIVE",

        Widget.CenterBox({
            class_name = "centerbox",
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
                valign = "END",
                halign = "END",
                vertical = true,
                xkb(),
                -- audio(),
                wireless(),
                battery(),
                power(),
            })
        })
    })
end
