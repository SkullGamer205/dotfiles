local astal = require('astal')
local Widget = require('astal.gtk3').Widget
local bind = astal.bind

return function(autio)
    local a = {
        icon = Widget.Icon({
            icon = bind(audio, "volume-icon"),
        }),

        label = Widget.Label({
            label = bind(audio, "volume"):as(
                function(p) return tostring(math.floor(p * 100)) .. "%" end
            ),
        })
    }

    return Widget.Box({
        a.icon,
    })
end
