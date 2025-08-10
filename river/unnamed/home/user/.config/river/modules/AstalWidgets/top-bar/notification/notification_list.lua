local astal = require("astal")
local Astal = require("astal.gtk3").Astal
local varlist = require("lib.common").varlist
local AstalNotifd = astal.require("AstalNotifd")
local App = require("astal.gtk3").App
local Widget = require("astal.gtk3").Widget
local Anchor = Astal.WindowAnchor
local Gdk = require("astal.gtk3").Gdk
local Gtk = require("astal.gtk3").Gtk
local Notification = require("top-bar.notification.notification")

return function()
    local notifd = AstalNotifd.get_default()
    local notif_l = varlist({})

    for _, n in ipairs(notifd:get_notifications()) do
	    notif_l.insert(Notification(n, function(self)
		    self:hook(n, "resolved", function()
			    notif_l.remove(self)
		    end)
	    end))
    end

    notifd.on_notified = function(_, id)
	    local n = notifd:get_notification(id)
	    notif_l.insert(1, Notification(n, function(self)
		    self:hook(n, "resolved", function()
			    notif_l.remove(self)
		    end)
	    end))
    end

    local notif_list = Widget.Box {
		class_name = "notification-list",
		vertical = true,
		spacing = 8,
		Widget.Box {
			class_name = "header",
			Widget.Label {
				class_name = "title",
				label = notif_l():as(function(l)
					return "Уведомления " ..
						(#l > 0 and "(" .. tostring(#l) .. ")" or "") .. ":"
				end)
			},
			Widget.Box {
				hexpand = true,
				halign = "END",
				Widget.Button {
					class_name = "clear-button",
					on_clicked = function()
						for _, n in ipairs(notifd:get_notifications()) do
							n:dismiss()
						end
					end,
					Widget.Icon {
						icon = "trash-symbolic"
					}
				}
			}
		},
                Widget.Scrollable {
		    vexpand = true,
		    Widget.Box {
                        vertical = true,
			    spacing = 8,
			    notif_l(),
			    Widget.Box {
				    class_name = "empty-massage",
				    expand = true,
				    halign = "CENTER",
				    valign = "CENTER",
				    visible = notif_l():as(function(v)
					return #v == 0
				    end),
				    Widget.Label {
					    label = "Нет уведомлений"
				    }
			    }
		    }
	    }
    }

    local notif_box = Widget.Box({
        name = "Notification-Box",
        class_name = "notif-window-box",
        width_request = 350,
        height_request = 400,
	hexpand = false,
        vexpand = false,
        spacing = 8,
        notif_list,
    })

    return Widget.Window({
        application = App,
        monitor = monitor,
        name = "Notification-List",
        class_name = "notif-window",
        anchor = Anchor.TOP ,
        exclusivity = "NORMAL",
        keymode = "ON_DEMAND",
        visible = false,
        notif_box,
        on_key_press_event = function(self,event)
            if event.keyval == Gdk.KEY_Escape then
                self:hide()
            end
        end,
    })
end
