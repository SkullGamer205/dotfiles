local Astal     = require("astal")
local App       = require("astal.gtk3.app")
local Widget    = require("astal.gtk3").Widget
local Variable  = Astal.Variable

local GLib = Astal.require("GLib")
local bind = Astal.bind

local function Time(format)
    local time = Variable.new(""):poll(1000, function()
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
        label = bind(time),
    })
end

return function(gdkmonitor)
    local current_window = nil
    local window_visible = Variable(false)

    local function toggle_window(gdkmonitor)
        if window_visible:get() and current_window then
            current_window:hide()
            window_visible:set(false)
        else
            if not current_window then
                local CurrentWindow = require("windows.clock")
                current_window = CurrentWindow.new(gdkmonitor)
            end
            if current_window then
                current_window:show_all()
            end
                window_visible:set(true)
        end
    end

    return Widget.Button({
        class_name = "button-clock",
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                toggle_window(gdkmonitor)
            end
        end,

        Time("%H\n%M"),
    })
end

