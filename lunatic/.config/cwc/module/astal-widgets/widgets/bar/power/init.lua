local App = require("astal.gtk3.app")
local Widget = require("astal.gtk3").Widget

local Debug = require("lib.debug")


return function()

    return Widget.Button({
        class_name = "button-power",
        on_click_release = function(_, event)
            local powerbox = App:get_window("PowerBox")
            if event.button == "PRIMARY" then
                if powerbox then
                    if not powerbox:get_visible() then
                        powerbox:show()
                    else
                        powerbox:hide() 
                    end
                else
                    Debug.error("PowerButton", "Unable to open PowerBox")
                end
            end
        end,

        Widget.Icon({
            icon = "system-shutdown-symbolic",
        }),

        on_destroy = function()
            powerbox:destroy()
        end
    })
end
