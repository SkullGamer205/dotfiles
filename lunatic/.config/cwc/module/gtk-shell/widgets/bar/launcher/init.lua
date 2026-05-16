local lgi  = require('lgi')
local GLib = lgi.require('GLib')
local Gtk  = lgi.require('Gtk', '3.0')

local function BaseButton()
    local launcher_icon = Gtk.Image({
        icon_name = 'system-search'
    })

    local current_window = nil
    local window_visible = false
    
    local toggle_window = function()
        if current_window and window_visible then
            current_window:hide()
            window_visible = false
        else
            if not current_window then
                local CurrentWindow = require('windows.launcher.init')
                current_window = CurrentWindow.new()
            end
            if current_window then
                current_window:show_all()
            end
            window_visible = true
        end
    end

    local launcher_box = Gtk.Box({ launcher_icon })
    local launcher_button = Gtk.Button({
        launcher_box,
        on_clicked = function() toggle_window() end
    })

    return launcher_button
end

return function()
    return BaseButton()
end
