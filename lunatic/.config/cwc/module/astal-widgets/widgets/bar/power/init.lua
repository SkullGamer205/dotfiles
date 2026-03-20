local App       = require("astal.gtk3.app")
local Widget    = require("astal.gtk3").Widget
local Variable  = require("astal").Variable

local Debug = require("lib.debug")


return function(gdkmonitor)
    local current_window = nil
    local window_visible = Variable(false)

    -- local function toggle_window()
    --     local powerbox = App:get_window("PowerBox")
    --     if powerbox then
    --         if not powerbox:get_visible() then
    --             powerbox:show()
    --         else
    --             powerbox:hide() 
    --         end
    --     else
    --         Debug.error("PowerButton", "Unable to open PowerBox")
    --     end
    -- end
    local function toggle_window(gdkmonitor)
        if window_visible:get() and current_window then
            current_window:hide()
            window_visible:set(false)
        else
            if not current_window then
                local CurrentWindow = require("windows.power")
                current_window = CurrentWindow.new(gdkmonitor)
            end
            if current_window then
                current_window:show_all()
            end
                window_visible:set(true)
        end
    end

    return Widget.Button({
        class_name = "button-power",
        on_click_release = function(_, event)
            if event.button == "PRIMARY" then
                toggle_window(gdkmonitor)
            end
        end,

        Widget.Icon({
            icon = "system-shutdown-symbolic",
        }),

        -- on_destroy = function()
        --     powerbox:destroy()
        -- end
    })
end
