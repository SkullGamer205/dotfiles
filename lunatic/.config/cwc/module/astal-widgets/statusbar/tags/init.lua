local astal = require("astal")
local Widget = require("astal.gtk3").Widget

local function tag_button(tag)
    return Widget.Button({
       name = "Tag" .. tag,
        class_name = "button-tag",
        on_click_release = function(_, event)
        local t = string.format('cwc.screen.focused():get_tag(%s)', tag)
            if event.button == "PRIMARY" then
                os.execute('cwctl -c \"' .. t .. ':view_only()\"')
            elseif event.button == "SECONDARY" then
                os.execute('cwctl -c \"' .. t .. ':toggle()\"')
            else
                print("NOTHING")
            end
        end,

        Widget.Box({
           name = "Tag" .. tag,
            class_name = "box-tag",
            Widget.Label({
                class_name = "sting-tag",
                label = string.format('%s', tag)
            })
        })

    })
end

return function()
    local _tag_button = {}
    for i = 1, 9 do
        _tag_button[i] = tag_button(i)
    end

    return Widget.Box({
        vertical = true,
        table.unpack(_tag_button),
    })
end
