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
        return Widget.Box({
            Widget.Entry({
                text = "Test",
            })
        })
    end

    window = Widget.Window({
        class_name = "subwindow",
        gdkmonitor = gdkmonitor,
        anchor = Anchor.TOP + Anchor.BOTTOM,
        exclusivity = "IGNORE",
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
