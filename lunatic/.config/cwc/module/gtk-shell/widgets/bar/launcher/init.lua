local lgi  = require('lgi')
local GLib = lgi.require('GLib')
local Gtk  = lgi.require('Gtk', '3.0')

local function BaseButton()
    local launcher_icon = Gtk.Image({
        icon_name = 'system-search'
    })

    local toggle_window = function()
        print("LauncherButton: Work In Progress")
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
