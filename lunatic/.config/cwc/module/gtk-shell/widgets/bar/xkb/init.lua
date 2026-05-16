local lgi  = require('lgi')
local GLib = lgi.require('GLib')
local Gdk  = lgi.require('Gdk')
local Gtk  = lgi.require('Gtk', '3.0')

-- Tag button template
local KBD_LayoutBox = function(tag)
    local kbd_label = "return string.upper(string.sub(cwc.kbd.get()[1].layout_name, 1, 2))"

    local xkb_label = Gtk.Label.new(GLib.spawn_command_line_sync('cwctl -c \"' .. kbd_label .. '\"'))
    local xkb_button = Gtk.Box({
        xkb_label
    })

    local function update_func()
        xkb_label:set_text(GLib.spawn_command_line_sync('cwctl -c \"' .. kbd_label .. '\"'))
        return true
    end

    GLib.timeout_add(GLib.PRIORITY_DEFAULT, 500, update_func)
    return xkb_button
end

return function()
    return KBD_LayoutBox()
end
