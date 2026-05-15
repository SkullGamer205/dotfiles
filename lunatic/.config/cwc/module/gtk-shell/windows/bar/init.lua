local ffi = require("ffi")
ffi.C = ffi.load("gtk-layer-shell")

local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")
local LayerShell = lgi.require("GtkLayerShell")

local widgetsDir = 'widgets.bar'
local launcher      = require(widgetsDir .. '.launcher.init')
local tags          = require(widgetsDir .. '.tags.init')
local player        = require(widgetsDir .. '.player.init')
local clock         = require(widgetsDir .. '.clock.init')
local notification  = require(widgetsDir .. '.notification.init')
local tray          = require(widgetsDir .. '.tray.init')
local power         = require(widgetsDir .. '.power.init')

return function()
    local    top_widgets = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)
    local middle_widgets = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)
    local bottom_widgets = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)

    top_widgets:add(launcher())
    top_widgets:add(tags())

    middle_widgets:add(player())
    middle_widgets:add(clock())
    middle_widgets:add(notification())
    
    bottom_widgets:add(tray())
    bottom_widgets:add(power())

    local bar_mainbox = Gtk.Box({
        orientation = Gtk.Orientation.VERTICAL,
    })
    bar_mainbox:pack_start(top_widgets, false, false, 0)
    bar_mainbox:set_center_widget(middle_widgets, false, false, 0)
    bar_mainbox:pack_end(bottom_widgets, false, false, 0)

    return bar_mainbox
end
