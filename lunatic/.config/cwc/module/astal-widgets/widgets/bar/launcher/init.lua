local Astal     = require("astal")
local Astal3    = require("astal.gtk3")

local Widget    = Astal3.Widget
local Variable  = Astal.Variable
local bind      = Astal.bind

local Debug     = require("lib.debug")

return function(gdkmonitor)
    local current_window = nil
    local window_visible = Variable(false)

    local function toggle_window(gdkmonitor)
        if window_visible:get() and current_window then
            current_window:hide()
            window_visible:set(false)
        else
            if not current_window then
                local CurrentWindow = require("windows.launcher")
                current_window = CurrentWindow.new(gdkmonitor)
            end
            if current_window then
                current_window:show()
            end
            window_visible:set(true)
        end
    end

    local button = Widget.Button({
        class_name = "button-launcher",
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                toggle_window(gdkmonitor)
            end
        end,
        Widget.Icon({
            icon = "system-search",
        }),
    })

    return button
end

