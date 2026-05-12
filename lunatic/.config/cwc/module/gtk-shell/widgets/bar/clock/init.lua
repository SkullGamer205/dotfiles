local lgi  = require('lgi')
local GLib = lgi.require('GLib')
local Gtk  = lgi.require('Gtk', '3.0')

local function Time(format)
    local time_label = Gtk.Label.new(os.date(format))

    local function update_func()
        time_label:set_text(os.date(format))
        return true
    end

    GLib.timeout_add_seconds(GLib.PRIORITY_DEFAULT, 1, update_func)
    return time_label
end

return function()
    local clock_box = Gtk.Box()
    clock_box:add(Time("%H\n%M"))

    return clock_box
end
