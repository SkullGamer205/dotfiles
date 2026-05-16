local lgi = require('lgi')
local Gtk = lgi.require('Gtk', '3.0')
local LayerShell = lgi.require('GtkLayerShell')

local power_box = function(p)
    return Gtk.Box({
        orientation = "VERTICAL",
        table.unpack(p)
    })
end

local function power_button(props)
    local p_icon = Gtk.Image({
        icon_name = props.icon,
    })

    local p_button = Gtk.Button({
        p_icon,
        on_clicked = function()
            os.execute(props.cmd)
        end
    })
    return p_button
end

local PowerWindow = {}

function PowerWindow.new()
    local power_window
    local power_buttons = {}
    local _btns = {
        [1] = {icon = "system-shutdown-symbolic",       cmd = "loginctl poweroff"},
        [2] = {icon = "system-reboot-symbolic",         cmd = "loginctl reboot"},
        [3] = {icon = "system-lock-screen-symbolic",    cmd = "loginctl lock-session self"},
        [4] = {icon = "system-log-out-symbolic",        cmd = "loginctl kill-session self"},
        [5] = {icon = "system-hibernate-symbolic",      cmd = "loginctl hibernate"},
        [6] = {icon = "sleep",                          cmd = "loginctl suspend"},
    }
    
    for i =1, #_btns do
        power_buttons[i] = power_button({
            icon = _btns[i].icon,
            cmd  = _btns[i].cmd,
        })
    end

    power_window = Gtk.Window({
        title = "PowerWindow",
        window_position = Gtk.WindowPosition.MOUSE,
        power_box(power_buttons)
    })

    LayerShell.init_for_window(power_window)
    LayerShell.set_layer(power_window, LayerShell.Layer.TOP)
    LayerShell.set_anchor(power_window, LayerShell.Edge.LEFT, false)
    LayerShell.set_anchor(power_window, LayerShell.Edge.RIGHT, true)
    LayerShell.set_anchor(power_window, LayerShell.Edge.TOP, false)
    LayerShell.set_anchor(power_window, LayerShell.Edge.BOTTOM, true)
    return power_window
end

return PowerWindow

