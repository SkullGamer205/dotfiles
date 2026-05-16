local lgi = require('lgi')
local Gtk = lgi.require('Gtk', '3.0')
local LayerShell = lgi.require('GtkLayerShell')

local launcher_label = Gtk.Label.new("Launcher")

local launcher_box = Gtk.Box({
        orientation = "VERTICAL",
        launcher_label
    })

local LauncherWindow = {}

function LauncherWindow.new()
    launcher_window = Gtk.Window({
        title = "LauncherWindow",
        window_position = Gtk.WindowPosition.MOUSE,
        launcher_box
    })

    LayerShell.init_for_window(launcher_window)
    LayerShell.set_layer(launcher_window,  LayerShell.Layer.TOP)
    return launcher_window
end

return LauncherWindow

