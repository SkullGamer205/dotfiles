local Widget = require("astal.gtk3").Widget

return function()
    return Widget.Button({
        class_name="button-power",
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                print("PRIMARY")
            elseif event.button == "SECONDARY" then
                print("SECONDARY") 
            end
        end,
        Widget.Icon({
            icon = "system-shutdown-symbolic",
        }),
    })
end
