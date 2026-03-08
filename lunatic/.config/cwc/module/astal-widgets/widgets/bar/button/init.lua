local Widget = require("astal.gtk3").Widget

return function(label, icon, leftclick, rightclick)
    return Widget.Button({
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                leftclick()
            elseif event.button == "SECONDARY" then
                rightclick()
            end
        end,
        Widget.Label({
            label = label,
        }),
        Widget.Icon({
            icon = icon,
        }),
    })
end
