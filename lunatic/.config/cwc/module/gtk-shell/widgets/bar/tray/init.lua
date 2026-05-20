local lgi  = require('lgi')
local Gio  = lgi.Gio
local GLib = lgi.require('GLib')
local Gtk  = lgi.require('Gtk', '3.0')

local bus = Gio.bus_get_sync(Gio.BusType.SESSION, nil)

local get_registered_items = function(bus)
    local proxy = Gio.DBusProxy.new_sync(
        bus,
        Gio.DBusProxyFlags.NONE,
        nil,    -- GDbusInterfaceInfo
        'org.kde.StatusNotifierWatcher', -- service name
        '/StatusNotifierWatcher',
        'org.kde.StatusNotifierWatcher', -- Interface
        nil
    )

    local result, error = proxy:call_sync(
        'RegisteredStatusNotifierItems',    -- Method
        nil,        -- Glib.Variant parameters
        Gio.DBusCallFlags.NONE,
        -1,     -- timeous
        nil     -- GCancellable
    )

    if error then
        print('Error calling RegisteredStatusNotifierItems: ', error.message)
        return {}
    end

    local items = result:get_strv()
    for _, service_name in pairs(items) do
        print("Found StatusNotifierItem: ", service_name)
    end
    
    return items
end

local active_items = get_registered_items(bus)

local function BaseButton()
    local tray_label = Gtk.Label({
        label = "0"
    })

    local toggle_window = function()
        print("TrayButton: Work In Progress")
    end

    local tray_box = Gtk.Box({ tray_label })
    local tray_button = Gtk.Button({
        tray_box,
        on_clicked = function() toggle_window() end
    })

    return tray_button
end

return function()
    return BaseButton()
end
