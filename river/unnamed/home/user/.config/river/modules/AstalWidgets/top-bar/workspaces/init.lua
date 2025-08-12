local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local Variable = astal.Variable
local bind = astal.bind
local River = require("lgi").require("AstalRiver")

local function tag_button(props)
    return Widget.Button({

        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                os.execute(string.format('riverctl set-focused-tags %s', props.tag_bin))
            elseif event.button == "SECONDARY" then
                os.execute(string.format('riverctl toggle-focused-tags %s', props.tag_bin))
            else
                print("NOTHING")
            end
        end,

        Widget.Box({
            name = "TagButton_" .. props.tag,
            class_name = "btn_tag",
            Widget.Label({
                label = string.format('%s', props.tag)
            })
        })
    })
end

return function()
    local tag_btn = {}

    for i = 1, 9 do
        local tag_num = 1 << (i - 1)
        tag_btn[i] = tag_button({
            tag_bin = tag_num,
            tag = i,      
        })
    end

    return Widget.Box({
        table.unpack(tag_btn),
    })
end
