local astal = require("astal")
local bind = astal.bind
local Variable = require("astal").Variable
local Widget = require("astal.gtk3.widget")

return function(audio)
    local audio_visibility = Variable()

    local audio_icon = Widget.Icon({
        icon = bind(audio, "volume-icon"),
    })

    local audio_label = Widget.Label({ 
        css = "margin-right: 4px",
        label = bind(audio, "volume"):as(
            function(p) return tostring(math.floor(p * 100)) .. "%" end
        ),
    })

    return Widget.EventBox({
        on_hover = function()
            audio_visibility:set(true)
        end,

        on_hover_lost = function()
            audio_visibility:set(false)
        end,
        
        Widget.Box({
            Widget.Revealer({
                reveal_child = bind(audio_visibility),
                transition_type = "SLIDE_LEFT",
                audio_label,
            }),
            audio_icon,
        })
    })
end

