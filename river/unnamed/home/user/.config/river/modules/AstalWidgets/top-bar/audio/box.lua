local astal = require("astal")
local Astal  = require("astal.gtk3")
local App    = Astal.App
local Widget = require("astal.gtk3.widget")
local Wp = astal.require("AstalWp")
local w_audio = require("top-bar.audio.audio")

return function()
    local WpAudio = Wp.get_default()
    local speaker = WpAudio:get_default_speaker()
    local micro = WpAudio:get_default_microphone()

    return Widget.EventBox({
        class_name = "ebx-audio",
        on_click_release = function(_, event)
            local w_audio = App:get_window("SoundWindow")
            if event.button == "PRIMARY" then
                if w_audio then
                    if not w_audio:get_visible() then
                        w_audio:show()
                    else
                        w_audio:hide()
                    end
                end
            end
        end,

        Widget.Box({
            class_name = "box-audio",
            css = "padding: 0 0.5em 0 0.5em",
        w_audio(micro),
        w_audio(speaker),
        })
    })
end
