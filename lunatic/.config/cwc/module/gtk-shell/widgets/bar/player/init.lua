local lgi  = require('lgi')
local GLib = lgi.require('GLib')
local Gtk  = lgi.require('Gtk', '3.0')

local function BaseButton()
    local player_icon = Gtk.Image({
        icon_name = 'music-note-symbolic'
    })

    local toggle_window = function()
        print("PlayerButton: Work In Progress")
    end

    local player_box = Gtk.Box({ player_icon })
    local player_button = Gtk.Button({
        player_box,
        on_clicked = function() toggle_window() end
    })

    return player_button
end

return function()
    return BaseButton()
end
