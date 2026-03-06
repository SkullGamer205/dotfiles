local astal = require("astal")
local Widget = require("astal.gtk3").Widget

local cwc = cwc

local function tag_button(tag)
    return Widget.Button({
        name = "Tag" .. tag,
        class_name = "button-tag",
        t = cwc.screen.focused():get_tag(tag),
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                t:view_only()
            elseif event.button == "SECONDARY" then
                t:toggle()
            else
                print("NOTHING")
            end
        end,
    })
end

return function()
    local _tag_button = {}
    for i = 1, 9 do
        _tag_button[i] = tag_button(i)
    end

    Widget.Box({
        table.unpack(_tag_button),
    })
end
