local astal = require("astal")
local bind = astal.bind
local Variable = require("astal").Variable
local Widget = require("astal.gtk3.widget")
local Wp = astal.require("AstalWp")

return function()
    local speaker = Wp.get_default().audio.default_speaker
    local speaker_visibility = Variable()

    local speaker_icon = Widget.Icon({
        css = "margin-right: 4px",
        icon = bind(speaker, "volume-icon"),
    })

    local speaker_label = Widget.Label({ 
        css = "margin-right: 4px",
        label = bind(speaker, "volume"):as(
            function(p) return tostring(math.floor(p * 100)) .. "%" end
        ),
    })

    return Widget.EventBox({
        on_hover = function()
            speaker_visibility:set(true)
        end,

        on_hover_lost = function()
            speaker_visibility:set(false)
        end,
        
        Widget.Box({
            speaker_icon,
            Widget.Revealer({
                reveal_child = bind(speaker_visibility),
                transition_type = "SLIDE_RIGHT",
                speaker_label,
            }),
        })
    })
end

