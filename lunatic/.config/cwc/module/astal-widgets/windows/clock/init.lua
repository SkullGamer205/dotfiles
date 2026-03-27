local Astal     = require("astal")
local Astal3    = require("astal.gtk3")

local Widget    = Astal3.Widget
local Variable  = Astal.Variable
local Anchor    = Astal3.Astal.WindowAnchor

local GLib      = Astal.require("GLib")
local bind      = Astal.bind
local Debug     = require("lib.debug")

local function Time(format, css)
    local time = Variable.new(""):poll(500, function()
        local success, datetime = pcall (function()
            return GLib.DateTime.new_now_local():format(format)
        end)
        return success and datetime or ""
    end)

    return Widget.Label({
        setup = function(self)
            self:hook(self, "destroy", function()
                time:drop()
            end)
        end,
        css = css or nil ,
        label = bind(time),
    })
end

local CurrentWindow = {}
function CurrentWindow.new(gdkmonitor)
    if not gdkmonitor then
        Debug.Error("ClockWindow", "No monitor available")
        return nil
    end

    local window

    local function clock_box()
        return Widget.Box({
            class_name = "box",
            width_request = 32,
            height_request = 32,
            Widget.Box({
                vertical = true,
                halign = "CENTER",
                    Time("%H\n%M", "font-size: 400%; font-weight: 800;"),
                    Time("%S", "font-size: 200%; font-weight: 400;"),
            })
        })
    end

    window = Widget.Window({
        gdkmonitor = gdkmonitor,
        class_name = "subwindow",
        anchor = Anchor.RIGHT,
        exclusivity = "NORMAL",
        layer = "OVERLAY",
        visible = false,

        clock_box(),
    })

    return window
end

return CurrentWindow
