local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local Variable = astal.Variable
local bind = astal.bind
-- local River = require("lgi").require("AstalRiver")

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
            class_name = "btn-tag",
            Widget.Label({
                label = string.format('%s', props.tag_name)
            })
        })
    })
end

return function()
    local tags_visibility = Variable()
    local tag_buttons = {}
    local tag_symbols = {
        [ 1] = '一', -- (yī) 
        [ 2] = '二', -- (èr)
        [ 3] = '三', -- (sān)
        [ 4] = '四', -- (sì)
        [ 5] = '五', -- (wǔ)
        [ 6] = '六', -- (liù)
        [ 7] = '七', -- (qī)
        [ 8] = '八', -- (bā)
        [ 9] = '九', -- (jiǔ)
        [10] = '十', -- (shí)
    }
    for i = 1, 9 do
        local tag_num = 1 << (i - 1)
        tag_buttons[i] = tag_button({
            tag_bin = tag_num,
            tag = i,
            tag_name = tag_symbols[i],
        })
    end

    return Widget.EventBox({
        class_name = "ebx-tags",
        on_hover = function()
            tags_visibility:set(true)
        end,

        on_hover_lost = function()
            tags_visibility:set(false)
        end,


        Widget.Box({
            class_name = "box-tags",
            Widget.Icon({
                class_name = "ico-tags",
                icon = "workspaces-symbolic",
                css = "font-size: 16px; padding: 0 0.5em 0 0.5em",
            }),
            Widget.Revealer({
                class_name = "rev-tags",
                reveal_child = bind(tags_visibility),
                transition_type = "SLIDE_RIGHT",
                Widget.Box({
                    class_name = "box-revtags",
                    table.unpack(tag_buttons),
                })
            })
        })
    })
end
