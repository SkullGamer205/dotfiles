local Widget = require("astal.gtk3.widget")

return function(text)
    return Widget.Button({
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                print("Left click")
            elseif event.button == "SECONDARY" then
                os.execute("foot")
            end
        end,
        Widget.Label({
            label = text,
        }),
    })
end
