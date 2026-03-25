local Astal     = require("astal")
local Astal3    = require("astal.gtk3")

local Widget    = Astal3.Widget
local Anchor    = Astal3.Astal.WindowAnchor
local Gdk       = Astal3.Gdk
local Variable  = Astal.Variable

local Debug     = require("lib.debug")

local CurrentWindow = {}

function CurrentWindow.new(gdkmonitor)
    if not gdkmonitor then
        Debug.Error("LauncherWindow", "No monitor available")
        return nil
    end

    local window

    local function launcher_box()
        local apps
        local app_list = Variable({})

        local entry = Widget.Entry({
            hexpand = true,
            -- MAYBE ADD TRANSLATION STRINGS?
            placeholder_text = "Search...",
        })

        local entry_cleaner = Widget.Button({
            Widget.Icon({
                icon = "edit-clear",
            })
        })

        return Widget.CenterBox({
            -- Background
            class_name = "launcher-box",
            css = string.format("background-image: url('%s')", "./oiai.png"),

            -- NEED FUNCTION TO GET MONITOR WIDTH/HEIGHT
            width_request = 768,
            height_request = 432,
            
            -- Right Box
            Widget.Box({
                class_name = "box-outline",
                vertical = true,
                halign = "END",
                width_request = 352,

                -- Search
                Widget.Box({
                    entry, 
                    entry_cleaner,
                }),

                -- List
                Widget.Box({
                    Widget.Scrollable({
                        vexpand = true,
                    })
                }),
            }),
        })
    end

    window = Widget.Window({
        class_name = "subwindow",
        gdkmonitor = gdkmonitor,
        anchor = Anchor.TOP + Anchor.BOTTOM,
        exclusivity = "NORMAL",
        layer = "OVERLAY",
        keymode = "ON_DEMAND",
        visible = false,
        on_key_press_event = function(self, event)
            if event.keyval == Gdk.KEY_Escape then self:hide() end
        end,

        launcher_box()
    })

    return window
end

return CurrentWindow
