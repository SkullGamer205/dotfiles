local Astal     = require("astal")
local Astal3    = require("astal.gtk3")

local Widget    = Astal3.Widget
local Anchor    = Astal3.Astal.WindowAnchor

local lgi       = require('lgi')
local GLib      = lgi.require('GLib', '2.0')
local Gtk       = lgi.require('Gtk', '3.0')

local bind      = Astal.bind
local Debug     = require("lib.debug")

local function DateTime(format, ...)
    local defines = {...}

    local success, datetime = pcall(function()
        local dt = GLib.DateTime.new_now_local()

        for _, define in ipairs(defines) do
            if type(define) == "function" then
                dt = define(dt)
            end
        end

        return dt:format(format)
    end)

    if success and datetime then
        return datetime
    else
        Debug.Error("TimeWindow", "Cannot get GLib.DateTime")
        return nil
    end
end

local function Time(format, css)
    local function update_t(label)
        if DateTime(format) then
            label:set_label(DateTime(format))
        end
    end

    local t_label = Widget.Label({
        css = css or nil,
        setup = function(self)
            GLib.timeout_add(GLib.PRIORITY_DEFAULT, 500, function()
                update_t(self)
                return true
            end)
        end,
    })

    return t_label
end

local function Calendar(format, ...)
    local defines = {...} or nil

    local function update_t(label)
        if DateTime(format, table.unpack(defines)) then
            label:set_label(DateTime(format, table.unpack(defines)))
        end
    end
    
    local t_label = Widget.Label({
        css = css or nil,
        setup = function(self)
            GLib.timeout_add(GLib.PRIORITY_DEFAULT, 1000, function()
                update_t(self)
                return true
            end)
        end,
    })

    return t_label
end

local CurrentWindow = {}
function CurrentWindow.new(gdkmonitor)
    if not gdkmonitor then
        Debug.Error("ClockWindow", "No monitor available")
        return nil
    end

    local window

    local function clock_box()
        return Widget.Box({
            class_name = "box",
            vertical = true,
            vexpand = true,
            halign = "CENTER",
            valign = "CENTER",
            Time("%H\n%M", "font-size: 500%; font-weight: 800;"),
            Time("%S", "font-size: 250%; font-weight: 600;"),
        })
    end

    local function calendar_box()
        local c_buttons = {}

        local function c_date_button(i, css)
            return Widget.Button({
                class_name = css or nil,
                Calendar("%a, %d", function(a) return a:add_days(i - 2) end),

                on_click_release = function(_, event)
                    if event.button == "PRIMARY" then
                        print(GLib.DateTime.new_now_local():add_days(i - 2):format("%Y-%m-%d"))
                    end
                end
            })
        end

        for i = 1, 7 do 
            
        c_buttons[i] = c_date_button(i)

        -- Highlight current day
            if GLib.DateTime.new_now_local():add_days(i - 2):get_day_of_year() == GLib.DateTime.new_now_local():get_day_of_year() then
                c_buttons[i] = c_date_button(i, "button-active")
            else
                c_buttons[i] = c_date_button(i, "button")
            end
        end

        return Widget.Box({
            vertical = true,
            table.unpack(c_buttons)
        })
    end

    window = Widget.Window({
        gdkmonitor = gdkmonitor,
        class_name = "subwindow",
        anchor = Anchor.RIGHT,
        exclusivity = "NORMAL",
        layer = "OVERLAY",
        visible = false,
        Widget.Box({
            class_name = "box-outline",
            clock_box(),
            calendar_box(),
            -- Calendar("%a, %d", function(a) return a:add_days(-1) end),
        })
    })

    return window
end

return CurrentWindow
