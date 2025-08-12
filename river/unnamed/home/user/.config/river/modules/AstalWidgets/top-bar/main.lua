local App = require("astal.gtk3.app")
local Widget = require("astal.gtk3.widget")
local MyButton = require("top-bar.button.init")
local tray = require("top-bar.tray.init")
local clock = require("top-bar.clock.init")
local box_kbd = require("top-bar.keyboard.init")
local box_battery = require("top-bar.battery.init") 
local box_wireless = require("top-bar.wireless.box")
local box_audio = require("top-bar.audio.box")
local box_tags = require("top-bar.workspaces.init")
local box_player = require("top-bar.player.init")
local btn_Menu = require("top-bar.launcher.button")
local btn_Notif = require("top-bar.notification.button")
local btn_power = require("top-bar.power.init")
local Anchor = require("astal.gtk3").Astal.WindowAnchor

return function(gdkmonitor)
    return Widget.Window({
        name = "Bar",
        class_name = "bar",
        application = App, 
        gdkmonitor = gdkmonitor,
        anchor = Anchor.TOP + Anchor.LEFT + Anchor.RIGHT,
        exclusivity = "EXCLUSIVE",
        Widget.CenterBox({
            Widget.Box({
                name = "LeftBox",
                class_name = "bar-leftbox",
                halign = "START", 
                btn_Menu(),
                box_tags(),
                -- Workspaces(),
                -- FocusedClient(),
            }),
        
            Widget.Box({
                name = "CenterBox",
                class_name = "bar-middlebox",
                box_player(), 
                clock(),
                btn_Notif(),
            }),
        
            Widget.Box({
                name = "RightBox",
                class_name = "bar-rightbox",
                halign = "END",
                tray(),
                box_kbd(),
                box_audio(),
                box_wireless(),
                box_battery(),
                btn_power(),
            }),
        }),
})
end
