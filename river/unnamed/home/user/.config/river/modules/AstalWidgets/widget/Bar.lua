local App = require("astal.gtk3.app")
local Widget = require("astal.gtk3.widget")
local MyButton = require("widget.MyButton")
local Tray = require("widget.Tray")
local Time = require("widget.Time")
local FocusedClient = require("widget.client")
-- local Workspaces = require("widget.Workspaces")
local Player = require("widget.Player")
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
