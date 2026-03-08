local astal  = require('astal')
local astal3 = require('astal.gtk3') 
local App    = astal3.App
local Widget = astal3.Widget

local Wp     = astal.require('AstalWp')
local WAudio = require(... .. '.audio')

return function()
    local WpAudio = Wp.get_default()
    local Speak   = WpAudio:get_default_speaker()
    local Micro   = WpAudio:get_default_microphone()

    return Widget.Box({
        vertical = true,
        WAudio(Micro),
        WAudio(Speak),
    })
end
