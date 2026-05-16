local lgi  = require('lgi')
local GLib = lgi.require('GLib')
local Gtk  = lgi.require('Gtk', '3.0')

-- Tag button template
local tag_button = function(tag)
    local t_button = Gtk.Button({
        label = tag,
    })

    function t_button:on_button_release_event(event)
        local cmd   = string.format('cwc.screen.focused():get_tag(%s)', tag)
        local null = string.format(' > /dev/null 2>&1')
        if event.button == 1 then   -- Left mouse click
            os.execute('cwctl -c \"' .. cmd .. ':view_only()\"' .. null)
        elseif event.button == 3 then    -- Right mouse click
            os.execute('cwctl -c \"' .. cmd .. ':toggle()\"' .. null)
        end
    end


    return t_button
end

-- Box with all buttons
local function TagBox()
    -- Table&function to pack several buttons
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
