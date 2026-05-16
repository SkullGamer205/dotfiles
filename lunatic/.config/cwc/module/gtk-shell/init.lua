-- Add directories
local configDir_CwC = ((os.getenv("XDG_CONFIG_HOME")) or (os.getenv("HOME") .. "/.config")) .. "/cwc"
local configDir_GtkShell = configDir_CwC .. "/module/gtk-shell"
package.path = package.path .. ";" .. configDir_GtkShell .. "/?.lua;" .. configDir_CwC .. "/?/init.lua"

-- Main libraries
pcall(require, "luarocks.loader")

-- gtk-layer-shell
-- ffi
-- poloz-z/candy-shell :: main.lua
local ffi = require("ffi")
ffi.C = ffi.load("gtk-layer-shell")

-- Base libs
local lgi = require('lgi')
local GLib = lgi.require("GLib")
local Gio = lgi.Gio
local Gtk = lgi.require("Gtk", "3.0")
local LayerShell = lgi.require("GtkLayerShell")

-- Modules
local WindowBar = require("windows.bar.init")

-- Init Application
local appID = "io.codeberg.akira25.lunatic-shell.Lua.Gtk3.Shell"
local appTitle = "Lunatic Shell"
local app = Gtk.Application.new(appID, Gio.ApplicationFlags.FLAGS_NONE)

-- Garbage collector
GLib.timeout_add_seconds(GLib.PRIORITY_LOW, 30, function()
    collectgarbage("collect")
    return true
end)

function app:on_startup()
    local bar_box = WindowBar()

    local bar_win = Gtk.ApplicationWindow({
        title = appTitle,
        application = self,
        child = bar_box,
    })

    LayerShell.init_for_window(bar_win)
    LayerShell.set_layer(bar_win,  LayerShell.Layer.BOTTOM)
    LayerShell.set_anchor(bar_win, LayerShell.Edge.LEFT,  false)
    LayerShell.set_anchor(bar_win, LayerShell.Edge.RIGHT,  true)
    LayerShell.set_anchor(bar_win, LayerShell.Edge.TOP,    true)
    LayerShell.set_anchor(bar_win, LayerShell.Edge.BOTTOM, true)
    LayerShell.auto_exclusive_zone_enable(bar_win)


    bar_win:show_all()
end

function app:on_activate()
    self.active_window:present()
end

return app:run(arg)
