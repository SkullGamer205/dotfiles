local lgi  = require('lgi')
local GLib = lgi.require('GLib')
local Gtk  = lgi.require('Gtk', '3.0')

local function BaseButton()
    local power_icon = Gtk.Image({
        icon_name = 'system-shutdown-symbolic'
    })

    local toggle_window = function()
        print("PowerButton: Work In Progress")
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
