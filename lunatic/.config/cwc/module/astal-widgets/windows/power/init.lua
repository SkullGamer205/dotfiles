local astal  = require("astal")
local astal3 = require("astal.gtk3")
local Astal  = astal3.Astal
local Widget = astal3.Widget

local App    = require("astal.gtk3.app")
local Apps   = astal.require("AstalApps")

local Debug  = require("lib.debug")

local power_box = function(p)
    return Widget.Box({
        class_name = "subwindow-box",
        expand   = false,
        vertical = true,
        table.unpack(p)
    })
end

local function power_button(props)
    return Widget.Button({
        class_name = "button",
        expand = false,
        on_click_release = function(_, event)
            local widget = App:get_window("PowerBox")
            if event.button == "PRIMARY" then
                os.execute(string.format("%s", props.cmd))
                widget:hide()
            end
        end,
        Widget.Icon({
            icon = string.format("%s", props.icon),
            css = "font-size: 48px;",
        })
    })
end

local PowerWindow = {}

function PowerWindow.new(gdkmonitor)
    if not gdkmonitor then
        Debug.error("PowerBox", "No monitor available")
        return nil
    end
    local power_window
    local buttons = {}
    local btns = {
        [1] = {icon = "system-shutdown-symbolic",       cmd = "loginctl poweroff"},
        [2] = {icon = "system-reboot-symbolic",         cmd = "loginctl reboot"},
        [3] = {icon = "system-lock-screen-symbolic",    cmd = "loginctl lock-session self"},
        [4] = {icon = "system-log-out-symbolic",        cmd = "loginctl kill-session self"},
        [5] = {icon = "system-hibernate-symbolic",      cmd = "loginctl hibernate"},
        [6] = {icon = "sleep",                          cmd = "loginctl suspend"},
    }

    for i = 1, #btns do
        buttons[i] = power_button({
            icon = btns[i].icon,
            cmd  = btns[i].cmd,
        })
    end

    power_window = Widget.Window({
            gdkmonitor = gdkmonitor,
            class_name = "subwindow",
            anchor = 20,
            exclusivity = "NORMAL",
            visible = false,
            power_box(buttons)
        })

    return power_window
end

return PowerWindow
