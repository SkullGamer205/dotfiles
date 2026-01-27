local cwc = cwc
local enum = require("cuteful.enum")
-- input device config
cwc.connect_signal("input::new", function(dev)
    dev.sensitivity   = -0.75
    dev.accel_profile = enum.libinput.ACCEL_PROFILE_FLAT

    if dev.name:lower():match("touchpad") then
        dev.sensitivity    = 0.7
        dev.natural_scroll = true
        dev.tap            = true
        dev.tap_drag       = true
        dev.dwt            = true
    end
end)
