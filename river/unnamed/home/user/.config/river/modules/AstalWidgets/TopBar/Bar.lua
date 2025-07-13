local App = require("astal.gtk3.app")
local Widget = require("astal.gtk3.widget")
local MyButton = require("TopBar.MyButton")
local Tray = require("TopBar.Tray")
local Time = require("TopBar.Time")
local Battery = require("TopBar.Battery") 
local Wifi = require("TopBar.Wifi")
local FocusedClient = require("TopBar.client")
-- local Workspaces = require("widget.Workspaces")
local Player = require("TopBar.Player")
local LauncherButton = require("TopBar.LauncherButton")
local Anchor = require("astal.gtk3").Astal.WindowAnchor

return function(monitor)
    return Widget.Window({
        name = "TopBar",
        application = App, 
        monitor = monitor,
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
                Player(), 
            }),
        
            Widget.Box({
                name = "RightBox",
                halign = "END",
                Tray(),
                Wifi(),
                Battery(),
                Time(" %Y年%m月%d日 │ %H:%M:%S "),
            }),
        }),
})
end
