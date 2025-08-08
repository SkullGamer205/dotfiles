local astal = require("astal")
local AstalNotifd = astal.require("AstalNotifd")
local App = require("astal.gtk3").App
local Widget = require("astal.gtk3").Widget


return function()
    local notif_icon = Widget.Icon({
        class_name = "notif-icon",
        icon = "notification",
    })

    return Widget.Box({
        class_name = "box-notif",
        Widget.Button({
            class_name = "btn-notif",
            css = "border: 0px",
            notif_icon,
            on_click_release = function(_, event)
                if event.button == "PRIMARY" then
                    local notif_window = App:get_window("Notification-List")
                    if notif_window then
                        if not notif_window:get_visible() then
                            notif_window:show()
                        else
                            notif_window:hide()
                        end
                    end
                elseif event.button == "SECONDARY" then
                    local notifd = AstalNotifd.get_default()
                    for _, n in ipairs(notifd:get_notifications()) do
                        n:dismiss()
                    end
                end
            end
        })
    })
end

