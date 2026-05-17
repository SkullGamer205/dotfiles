local lgi = require('lgi')
local Gtk = lgi.require('Gtk', '3.0')
local LayerShell = lgi.require('GtkLayerShell')

-- Entry
local search_entry = Gtk.Entry({
    placeholder_text = "Search..."
})

-- Button
local clean_icon = Gtk.Image({
    icon_name = 'edit-clear'
})

local entry_cleaner = Gtk.Button({
    clean_icon,
    on_clicked = function()
        search_entry:set_text('')
    end
})

-- Search panel
local search_box = Gtk.Box({
    search_entry,
    entry_cleaner
})

local launcher_box = Gtk.Box({
        orientation = "VERTICAL",
        search_box
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

