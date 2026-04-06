local Widget    = require("astal.gtk3").Widget

local lgi       = require('lgi')
local GLib      = lgi.require('GLib', '2.0')
local Gtk       = lgi.require('Gtk', '3.0')

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

local function DateTime_Label(format, css, timeout, ...)
    local defines = {...} or nil

    local function update_time(label)
        if DateTime(format, table.unpack(defines)) then
            label:set_label(DateTime(format, table.unpack(defines)))
        end
    end
    
    local t_label = Widget.Label({
        css = css or nil,
        setup = function(self)
            GLib.timeout_add(GLib.PRIORITY_DEFAULT, timeout, function()
                update_time(self)
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
            children = {
                DateTime_Label("%H\n%M", "font-size: 500%; font-weight: 800;", 500),
                DateTime_Label("%S", "font-size: 250%; font-weight: 600;", 500),
            },
        })
    end

    local function calendar_box()
        local c_buttons = {}

        local function c_date_button(i, style)
            return Widget.Button({
                class_name = style or "button",
                DateTime_Label("%a, %d", nil, 1000, function(a) return a:add_days(i - 2) end),

                on_click_release = function(_, event)
                    if event.button == "PRIMARY" then
                        print(GLib.DateTime.new_now_local():add_days(i - 2):format("%Y-%m-%d"))
                    end
                end
            })
        end

        for i = 1, 7 do 
            local now        = GLib.DateTime.new_now_local()
            local first_date = now:add_days(i - 2) 
            local is_today   = first_date:get_day_of_year() == now:get_day_of_year()

            local style = is_today and "button-active" or "button"
            c_buttons[#c_buttons + 1] = c_date_button(i, style) 
        end

        return Widget.Box({
            vertical = true,
            halign = "CENTER",
            valign = "CENTER",
            children = {table.unpack(c_buttons)}
        })
    end

    local function weather_box()
        local function current_geo()
            return Widget.Box({
                class_name = "box",
                hexpand = true,
                Widget.Icon({
                    icon = "gps", 
                    css = "font-size: 150%; font-weight: 600;",
                }),
                Widget.Label({
                    halign = "CENTER",
                    label = "Москва",
                    css = "font-size: 150%; font-weight: 600;",
                })
            })
        end
        
        local function current_weather()
            return Widget.Box({
                Widget.Box({
                    class_name = "box",
                    Widget.Icon({
                        icon = "weather-clouds",
                        css = "font-size: 400%;",
                    }),
                }),
                Widget.Box({
                    class_name = "box",
                    vertical = true,
                    Widget.Label({
                        css = "font-size: 400%; font-weight: 800;",
                        label = "0^C"
                    }),
                    Widget.Label({
                        label = "Ощущается как 0^C"
                    })
                }),
            })
        end

        local function hourly_forecast()
            local h_forecasts = {}

            local function h_forecast(i)
                return Widget.Box({
                    vexpand = true,
                    vertical = true,
                    class_name = "box",
                    Widget.Label({
                        label = string.format("%d:00", i),
                    }),
                    Widget.Icon({
                        icon = "weather-clouds",
                    }),
                    Widget.Label({
                        label = "0^C",
                    }),
                })
            end

            for i = 1, 24 do 
                h_forecasts[#h_forecasts + 1] = h_forecast(i - 1) 
            end

            return Widget.Box({
                    class_name = "box",
                Widget.Scrollable({
                    expand = true,
                    height_request = 64,
                    Widget.Box({
                        children = {table.unpack(h_forecasts)}
                    })
                }),
            })
        end

        return Widget.Box({
            vertical = true,
            halign = "CENTER",
            valign = "CENTER",
            children = {
                current_geo(),
                current_weather(),
                hourly_forecast(),
            },
        })
    end

    window = Widget.Window({
        gdkmonitor = gdkmonitor,
        class_name = "subwindow",
        anchor = "RIGHT",
        exclusivity = "NORMAL",
        layer = "OVERLAY",
        visible = false,
        Widget.Box({
            class_name = "box-outline",
            children = {
                weather_box(),
                calendar_box(),
                clock_box(),
            }
        })
    })

    return window
end

return CurrentWindow
