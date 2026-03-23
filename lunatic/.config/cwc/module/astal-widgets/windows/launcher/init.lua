local Astal     = require("astal")
local Astal3    = require("astal.gtk3")

local Widget    = Astal3.Widget
local Anchor    = Astal3.Astal.WindowAnchor
local Gdk       = Astal3.Gdk

local Debug     = require("lib.debug")

local CurrentWindow = {}

function CurrentWindow.new(gdkmonitor)
    if not gdkmonitor then
        Debug.Error("LauncherWindow", "No monitor available")
        return nil
    end

    local window

    local function launcher_box()
        return Widget.CenterBox({
            class_name = "launcher-box",
            css = string.format("background-image: url('%s')", "./oiai.png"),
            Widget.Box({
                width_request = 256,
                height_request = 384,
            }),
            
            Widget.Box({
                class_name = "box-outline",
                vertical = true,
                Widget.Box({
                    Widget.Entry({
                        placeholder_text = "Search...",
                    })
                }),
                Widget.Box({
                }),
            }),
        })
    end

    window = Widget.Window({
        class_name = "subwindow",
        gdkmonitor = gdkmonitor,
        anchor = Anchor.TOP + Anchor.BOTTOM,
        exclusivity = "NORMAL",
        layer = "OVERLAY",
        keymode = "ON_DEMAND",
        visible = false,
        on_key_press_event = function(self, event)
            if event.keyval == Gdk.KEY_Escape then self:hide() end
        end,

        launcher_box()
    })

    return window
end

return CurrentWindow
