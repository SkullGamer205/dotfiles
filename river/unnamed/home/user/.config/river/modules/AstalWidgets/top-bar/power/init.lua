local App       = require("astal.gtk3").App
local Widget    = require("astal.gtk3.widget")
local Debug     = require("lib.debug")

return function()
    return Widget.Button({
        on_click_release = function(_, event)
            local w_power = App:get_window("PowerWindow")
            if event.button == "PRIMARY" then
                if w_power then
                    if not w_power:get_visible() then
                        w_power:show()
                    else
                        w_power:hide()
                    end
                else
                    Debug.error("Bar", "Unable to get app 'PowerWindow'")
                end
            else
                return nil
            end
        end,
        
        Widget.Icon({
            icon = "system-shutdown-symbolic",
        })
    })
end
