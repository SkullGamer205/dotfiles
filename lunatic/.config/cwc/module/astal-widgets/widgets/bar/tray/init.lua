local Astal = require("astal")
local Tray  = Astal.require("AstalTray")
local Widget = require("astal.gtk3").Widget

local bind = Astal.bind
local Variable = Astal.Variable

return function()
    -- local function trayCounter()
    local tray = Tray.get_default()
    local trayCounter = Variable.new()
        :poll(1000, function()
            return tostring(#tray.items)
        end)
    --     local counter = 0
    --     for _ in pairs(tray.items) do
    --         counter = counter + 1
    --     end
    --     return counter
    -- end

    return Widget.Button({
        class_name="button-tray",
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                print("PRIMARY")
            elseif event.button == "SECONDARY" then
                print("SECONDARY") 
            end
        end,
        Widget.Label({
            label = bind(trayCounter):as(function(t)
                return string.format("%s",t)
            end),
        }),
    })
end
