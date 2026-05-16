local lgi  = require('lgi')
local GLib = lgi.require('GLib')
local Gtk  = lgi.require('Gtk', '3.0')

local function BaseButton()
    local power_icon = Gtk.Image({
        icon_name = 'system-shutdown-symbolic'
    })

    local current_window = nil
    local window_visible = false
    
    local toggle_window = function()
        if current_window and window_visible then
            current_window:hide()
            window_visible = false
        else
            if not current_window then
                local CurrentWindow = require('windows.power.init')
                current_window = CurrentWindow.new()
            end
            if current_window then
                current_window:show_all()
            end
            window_visible = true
        end
        -- print("PowerButton: Work In Progress")
    end

    local power_box = Gtk.Box({ power_icon })
    local power_button = Gtk.Button({
        power_box,
        on_clicked = function() toggle_window() end
    })

    return power_button
end

return function()
    return BaseButton()
end
