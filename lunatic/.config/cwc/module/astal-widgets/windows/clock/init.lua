local Astal     = require("astal")
local Astal3    = require("astal.gtk3")

local Widget    = Astal3.Widget
local Variable  = Astal.Variable
local Anchor    = Astal3.Astal.WindowAnchor

local lgi       = require('lgi')
local GLib      = lgi.require('GLib', '2.0')
local Gtk       = lgi.require('Gtk', '3.0')

local bind      = Astal.bind
local Debug     = require("lib.debug")

-- local function Time(format, css)
--     local function update(label)
--         local success, datetime = pcall(function()
--             return GLib.DateTime.new_now_local():format(format)
--         end)
--
--         if success and datetime then
--             label:set_label(datetime)
--         else
--             Debug.Error("TimeWindow", "Cannot get GLib.DateTime")
--         end
--     end
--
--     local w_label = Widget.Label({
--         css = css or nil,
--         setup = function(self)
--             GLib.timeout_add(GLib.PRIORITY_DEFAULT, 500, function()
--                 update(self)
--                 return true
--             end)
--         end,
--     })
--
--     return w_label
-- end

local function DateTime(format)
    local success, datetime = pcall(function()
        return GLib.DateTime.new_now_local():format(format)
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

    function calendar_box()
        local c_buttons = {}
        local now = GLib.DateTime.new_now_local()
        local start_date = now:add_days(-2)

        local function c_button(i, css)
            return Widget.Button({
                class_name = css;
                label = i,
            })
        end

        for i = 1, 7 do
            local day = start_date:add_days(i)
            local is_today = (day:get_day_of_year() == now:get_day_of_year())
            local label_text = day:format("%a, %d")

            c_buttons[i] = c_button(label_text)

            if is_today then
                c_buttons[i] = c_button(label_text, "button-active")
            else
                c_buttons[i] = c_button(label_text, "button")
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
        })
    })

    return window
end

return CurrentWindow
