local App = require("astal.gtk3.app")
local Widget = require("astal.gtk3.widget")
local MyButton = require("top-bar.button.init")
local tray = require("top-bar.tray.init")
local clock = require("top-bar.clock.init")
local Kbd_Layout = require("top-bar.keyboard.init")
local Battery = require("top-bar.battery.init") 
-- local Wifi = require("top-bar.wireless.wifi")
local box_wireless = require("top-bar.wireless.box")
local box_audio = require("top-bar.audio.box")
-- local Speaker = require("top-bar.audio.speaker")
-- local Microphone = require("top-bar.audio.microphone")
-- local FocusedClient = require("TopBar.client")
-- local Workspaces = require("widget.Workspaces")
local box_player = require("top-bar.player.init")
local btn_Menu = require("top-bar.launcher.button")
local btn_Notif = require("top-bar.notification.button")
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
                Kbd_Layout(),
                box_audio(),
                box_wireless(),
                Battery(),
                MyButton("ПИТАНИЕ"),
            }),
        }),
})
end
