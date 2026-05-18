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

-- Debug lib
local Debug = require('lib.debug')
Debug.set_config({
    log_to_file = true,
    log_to_console = true,
    log_level = Debug.LEVELS.DEBUG,
})

Debug.info('Lunatic Shell', 'Initialization...')

-- Base libs
local lgi = require('lgi')
local Gio = lgi.Gio
local GLib = lgi.require("GLib")
local Gdk = lgi.require("Gdk", "3.0")
local Gtk = lgi.require("Gtk", "3.0")
local LayerShell = lgi.require("GtkLayerShell")
    
-- Modules
local WindowBar = require("windows.bar.init")

Debug.info('Lunatic Shell', 'Base libs loaded succesfully')

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
    -- Get display
    local display = Gdk.Display.get_default()
    if not display then
        Debug.error('Lunatic Shell', 'Display server (X11/Wayland) not found. Closing')
        os.exit(1)
    end

    -- Get monitors info
    local monitor_list = {}
    local n_monitors = display:get_n_monitors()

    for i = 0, n_monitors - 1 do
        local monitor = display:get_monitor(i)
        if monitor then
            local monitor_name = monitor:get_model() or monitor:get_connector() or ("Unknown-" .. i)
            table.insert(monitor_list, {
                object = monitor,
                name   = monitor_name
            })
            Debug.debug('Lunatic Shell', 'Found monitor: ' .. monitor_name)
        end
    end

    if #monitor_list == 0 then
        Debug.error('Lunatic Shell', 'Monitors not found. Closing')
        os.exit(1)
    end

    local create_windows = function(monitor_data)
        local bar_box = WindowBar()

        local bar_win = Gtk.ApplicationWindow({
            title = appTitle .. '-monitor-' .. monitor_data.name,
            application = self,
            child = bar_box,
        })

        LayerShell.init_for_window(bar_win)
        LayerShell.set_monitor(bar_win, monitor_data.object)

        LayerShell.set_layer(bar_win,  LayerShell.Layer.BOTTOM)
        LayerShell.set_anchor(bar_win, LayerShell.Edge.LEFT,  false)
        LayerShell.set_anchor(bar_win, LayerShell.Edge.RIGHT,  true)
        LayerShell.set_anchor(bar_win, LayerShell.Edge.TOP,    true)
        LayerShell.set_anchor(bar_win, LayerShell.Edge.BOTTOM, true)
        LayerShell.auto_exclusive_zone_enable(bar_win)


        bar_win:show_all()
        Debug.debug('Lunatic Shell', 'Create bar at monitor-' .. monitor_data.name)
    end

    for _, monitor_data  in pairs(monitor_list) do
        create_windows(monitor_data)
    end
end

function app:on_activate()
    Debug.info('Lunatic Shell', 'Instance is running')
    self.active_window:present()
end

return app:run(arg)

