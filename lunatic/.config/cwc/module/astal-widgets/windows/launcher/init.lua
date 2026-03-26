local Astal     = require("astal")
local Astal3    = require("astal.gtk3")

local Apps      = Astal.require("AstalApps")
local Widget    = Astal3.Widget
local Anchor    = Astal3.Astal.WindowAnchor
local Gdk       = Astal3.Gdk
local Variable  = Astal.Variable
local bind      = Astal.bind

local Debug     = require("lib.debug")
local slice     = require("lib.common").slice
local map       = require("lib.common").map

local CurrentWindow = {}

function CurrentWindow.new(gdkmonitor)
    if not gdkmonitor then
        Debug.Error("LauncherWindow", "No monitor available")
        return nil
    end

    local window

    local function launcher_box()
        local apps = Apps.Apps()
        local text = Variable.new("")

        local list = bind(text):as(function(t)
            return slice(apps:fuzzy_query(t), 1)
        end)

        local entry = Widget.Entry({
            hexpand = true,
            -- MAYBE ADD TRANSLATION STRINGS?
            placeholder_text = "Search...",
            text = bind(text),
            on_changed = function(self) text:set(self.text) end
        })

        local entry_cleaner = Widget.Button({
            Widget.Icon({
                icon = "edit-clear",
            })
        })

        local function AppButton(app)
            return Widget.Button({
                on_clicked = function()
                    app:launch()
                end,

                Widget.Box({
                    Widget.Icon({ icon = app.icon_name }),
                    Widget.Box({
                        valign = "CENTER",
                        vertical = true,
                        Widget.Label({
                            wrap = true,
                            xalign = 0,
                            label = app.name,
                        }),
                        app.description and Widget.Label({
                            wrap = true,
                            xalign = 0,
                            label = app.description,
                        }),
                    })
                })
            })
        end

        local not_found = Widget.Box({
            valign = "CENTER",
            halign = "CENTER",
            vexpand = true,
            vertical = true,
            visible = list:as(function(l) return #l == 0 end),
            Widget.Icon({ icon = "system-search-symbolic" }),
            Widget.Label({ label = "Упс! Ничего не найдено." }),
        })

        local app_list = Widget.Box({
            vertical = true,
            list:as(function(l) return map(l, AppButton) end),
            not_found,
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
                hexpand = false,
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
                        width_request = 352,
                        vexpand = true,
                        app_list,
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
