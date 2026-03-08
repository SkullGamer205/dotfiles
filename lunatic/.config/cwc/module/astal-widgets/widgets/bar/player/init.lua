local Widget = require("astal.gtk3").Widget

return function()
    return Widget.Button({
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                print("PRIMARY")
            elseif event.button == "SECONDARY" then
                print("SECONDARY") 
            end
        end,
        Widget.Icon({
            icon = "music-note-symbolic",
        }),
    })
end
