local App = require("astal.gtk3.app")
local Widget = require("astal.gtk3.widget")
local MyButton = require("TopBar.MyButton")
local Tray = require("TopBar.Tray")
local Time = require("TopBar.Time")
local FocusedClient = require("TopBar.client")
-- local Workspaces = require("widget.Workspaces")
local Player = require("TopBar.Player")
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
                halign = "START",
                MyButton("Пуск"),
                -- Workspaces(),
                -- FocusedClient(),
            }),
        
            Widget.Box({
                Player(), 
            }),
        
            Widget.Box({
                halign = "END",
                Tray(),
                Time("%Y.%m.%d | %H:%M:%S "),
            }),
        }),
})
end
