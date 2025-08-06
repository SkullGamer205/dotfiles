local App = require("astal.gtk3.app")
local Widget = require("astal.gtk3.widget")
local MyButton = require("TopBar.MyButton")
local Tray = require("TopBar.Tray")
local Clock = require("TopBar.Clock")
local Kbd_Layout = require("TopBar.Kbd_Layout")
local Battery = require("TopBar.Battery") 
local Wifi = require("TopBar.Wifi")
local Speaker = require("TopBar.Speaker")
local Microphone = require("TopBar.Microphone")
local FocusedClient = require("TopBar.client")
-- local Workspaces = require("widget.Workspaces")
local Player = require("TopBar.Player")
local LauncherButton = require("TopBar.LauncherButton")
local NotificationButton = require("TopBar.NotificationButton")
local Anchor = require("astal.gtk3").Astal.WindowAnchor

return function(gdkmonitor)
    return Widget.Window({
        name = "TopBar",
        application = App, 
        gdkmonitor = gdkmonitor,
        anchor = Anchor.TOP + Anchor.LEFT + Anchor.RIGHT,
        exclusivity = "EXCLUSIVE",
        Widget.CenterBox({
            Widget.Box({
                name = "LeftBox",
                halign = "START", 
                LauncherButton(),
                -- MyButton("Пуск"),
                -- Workspaces(),
                -- FocusedClient(),
            }),
        
            Widget.Box({
                name = "CenterBox",
                -- Time("%H:%M"),
                Player(), 
                Clock(),
                NotificationButton(),
            }),
        
            Widget.Box({
                name = "RightBox",
                halign = "END",
                Tray(),
                Kbd_Layout(),
                Speaker(),
                Microphone(),
                Wifi(),
                Battery(),
                MyButton("ПИТАНИЕ"),
                -- Time(" %Y年%m月%d日 │ %H:%M:%S "),
                -- NotificationButton(),
            }),
        }),
})
end
