local lgi  = require('lgi')
local GLib = lgi.require('GLib')
local Gtk  = lgi.require('Gtk', '3.0')

local function BaseButton()
    local notif_icon = Gtk.Image({
        icon_name = 'notification-active'
    })

    local toggle_window = function()
        print("NotificationButton: Work In Progress")
    end

    local notif_box = Gtk.Box({ notif_icon })
    local notif_button = Gtk.Button({
        notif_box,
        on_clicked = function() toggle_window() end
    })

    return notif_button
end

return function()
    return BaseButton()
end
