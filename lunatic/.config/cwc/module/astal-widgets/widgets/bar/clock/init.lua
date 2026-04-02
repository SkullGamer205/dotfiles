local Astal     = require("astal")
local App       = require("astal.gtk3.app")
local Widget    = require("astal.gtk3").Widget

local lgi  = require("lgi")
local GLib = Astal.require("GLib")
local Gtk  = lgi.require("Gtk", "3.0")

local Debug = require("lib.debug")

local function Time(format)
    local function update_time(label)        
        local success, datetime = pcall(function()
            return GLib.DateTime.new_now_local():format(format)
        end)

        if success and datetime then
            label:set_label(datetime)
        else
            Debug.Error("Time", "Cannot get GLib.DateTime")
        end
    end

    local time_label = Widget.Label({
        setup = function(self)
            GLib.timeout_add_seconds(GLib.PRIORITY_DEFAULT, 1, function()
                update_time(self)
                return true
            end)
        end,
    })

    return time_label
end

return function(gdkmonitor)
    local current_window = nil
    local window_visible = false

    local function toggle_window(gdkmonitor)
        if window_visible and current_window then
            current_window:hide()
            window_visible = false
        else
            if not current_window then
                local CurrentWindow = require("windows.clock")
                current_window = CurrentWindow.new(gdkmonitor)
            end
            if current_window then
                current_window:show_all()
            end
                window_visible = true
        end
    end

    return Widget.Button({
        class_name = "button-clock",
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                toggle_window(gdkmonitor)
            end
        end,

        child = Time("%H\n%M"),
    })
end

