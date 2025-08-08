local Astal  = require("astal.gtk3")
local App    = Astal.App
local Widget = require("astal.gtk3.widget")

local w_speaker = require("top-bar.audio.speaker")
local w_audio   = require("top-bar.audio.microphone")

return function()
    return Widget.EventBox({
        class_name = "ebx-audio",
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                print("LEFT")
            elseif event.button == "SECONDARY" then
                print("RIGHT")
            end
        end,
        Widget.Box({
            class_name = "box-audio",
            css = "padding: 0 0.5em 0 0.5em",
        w_audio(),
        w_speaker(),
        })
    })
end
