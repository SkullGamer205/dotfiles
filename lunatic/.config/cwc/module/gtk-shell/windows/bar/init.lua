local ffi = require("ffi")
ffi.C = ffi.load("gtk-layer-shell")

local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")
local LayerShell = lgi.require("GtkLayerShell")

local widgetsDir = 'widgets.bar'
local clock = require(widgetsDir .. '.clock.init')
local power = require(widgetsDir .. '.power.init')

return function()
    local    top_widgets = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)
    local middle_widgets = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)
    local bottom_widgets = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)

    middle_widgets:add(clock())
    bottom_widgets:add(power())

    local bar_mainbox = Gtk.Box({
        orientation = Gtk.Orientation.VERTICAL,
    })
    bar_mainbox:pack_start(top_widgets, false, false, 0)
    bar_mainbox:set_center_widget(middle_widgets, false, false, 0)
    bar_mainbox:pack_end(bottom_widgets, false, false, 0)

    return bar_mainbox
end
