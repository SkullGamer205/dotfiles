local lgi  = require('lgi')
local GLib = lgi.require('GLib')
local Gtk  = lgi.require('Gtk', '3.0')

local tag_button = function(tag)
    local t_button = Gtk.Button({
        label = tag,
        on_clicked = function(_, event)
            local cmd   = string.format('cwc.screen.focused():get_tag(%s)', tag)
            local dnull = string.format(' > /dev/null 2>1')
            if event.button == "PRIMARY" then
                os.execute('cwctl -c \"' .. cmd .. ':view_only()\"' .. dnull)
            elseif event.button == "SECONDARY" then 
                os.execute('cwctl -c \"' .. cmd .. ':toggle()\"' .. dnull)
            end
        end
    })

    return t_button
end

local function TagBox()
    local _tag_button = {}
    for i = 1, 4 do
        _tag_button[i] = tag_button(i)
    end

    local tags_box = Gtk.Box({
        orientation = "VERTICAL",
        table.unpack(_tag_button)
    })

    return tags_box
end

return function()
    return TagBox()
end
