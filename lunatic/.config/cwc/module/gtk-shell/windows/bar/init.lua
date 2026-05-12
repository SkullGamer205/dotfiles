local ffi = require("ffi")
ffi.C = ffi.load("gtk-layer-shell")

local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")
local LayerShell = lgi.require("GtkLayerShell")

local widgetsDir = 'widgets.bar'
local clock = require(widgetsDir .. '.clock.init')

return function()
    local    top_widgets = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)
    local middle_widgets = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)
    local bottom_widgets = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)

    local bar_mainbox = Gtk.Box({
        orientation = Gtk.Orientation.VERTICAL,
    })
    -- bar_mainbox:set_start_widget()
    bar_mainbox:set_center_widget(clock())
    -- bar_mainbox:set_end_widget()

    return bar_mainbox
end
