pcall(require, "luarocks.loader")
local Widget    = require("astal.gtk3").Widget

local lgi       = require('lgi')
local GLib      = lgi.require('GLib', '2.0')
local Gtk       = lgi.require('Gtk', '3.0')

local http      = require("socket.http")
local json      = require("dkjson")

local Debug     = require("lib.debug")



-- NOTE: NEED TO MAKE SEPARATE CONFIG.LUA/JSON FILE!!!
local w_config = {
    date        = GLib.DateTime.new_now_local():format("%Y-%m-%d"),
    timezone    = "auto",
    city        = "Khabarovsk",
    -- latitude    = nil,
    -- longitude   = nil,
    daily       = {
        "sunrise",
        "sunset"
    },
    hourly      = {
        "temperature_2m",
        "weather_code",
        "wind_speed_10m",
        "wind_direction_10m"
    },
    current     = {
        "temperature_2m",
        "weather_code",
        "apparent_temperature",
        "relative_humidity_2m",
        "wind_speed_10m",
        "wind_direction_10m"
    },
}

local function get_geo(w_args)
    Debug.debug("WeatherWidget", "City name are set. Trying to get coordinates")

    local site = "https://geocoding-api.open-meteo.com/v1/search?name=" .. w_args.city .. "&count=1&format=json"
    local response_body, status_code = http.request(site)

    if status_code == 200 then
        local data, pos, err = json.decode(response_body)
        
        if not err then
            Debug.debug("WeatherWidget_GetGeo", string.format("HTTP Request Success: %i", status_code))
            w_args.latitude  = data.results[1].latitude
            w_args.longitude = data.results[1].longitude
            w_args.city      = data.results[1].name
        else
            Debug.error("WeatherWidget_GetGeo", string.format("JSON Decode Error: %s", err))
        end
    else
        Debug.error("WeatherWidget_GetGeo", string.format("HTTP Request Failed: %i", status_code))
    end
end


local function get_weather(w_args)
    if w_args.latitude or w_args.longtude == nil then
        if w_args.city then
            Debug.warn("WeatherWidet", "Latitude and/or longture aren't set. Found 'city' variable. Trying to obtain coorditanes from city name")
            get_geo(w_args)
        else
            Debug.error("WeatherWidet", "Latitude and/or longture aren't set. 'city' variable not found. Weather widget cannot work!")
            return
        end
    end

    local site = "https://api.open-meteo.com/v1/forecast?latitude=".. w_args.latitude .."&longitude=".. w_args.longitude .."&daily=".. table.concat(w_args.daily, ",") .."&hourly=" .. table.concat(w_args.hourly, ",") .."&current=" .. table.concat(w_args.current, ",") .."&timezone=" .. w_args.timezone .. "&start_date=" .. w_args.date .. "&end_date=" .. w_args.date

    local response_body, status_code = http.request(site)

    if status_code == 200 then
        local data, pos, err = json.decode(response_body)

        if not err then
            Debug.debug("WeatherWidget", string.format("HTTP Request Success: %i", status_code))
            return data 
        else
            Debug.error("WeatherWidget", string.format("JSON Decode Error: %s", err))
        end
    else
        Debug.error("WeatherWidget", string.format("HTTP Request Failed: %i", status_code))
    end
end

local weather_data = get_weather(w_config)




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
                        -- print(GLib.DateTime.new_now_local():add_days(i - 2):format("%Y-%m-%d"))
                        local selected_date = GLib.DateTime.new_now_local():add_days(i - 2):format("%Y-%m-%d")
                        w_config.date = selected_date
                        Debug.debug("WeatherWidget", string.format("Selected date: %s", selected_date))
                        get_weather(w_config)

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
                    css = "font-size: 100%; font-weight: 600;",
                }),
                Widget.Label({
                    halign = "CENTER",
                    label = (w_config.city or "Неизвестно"),
                    css = "font-size: 100%; font-weight: 400;",
                })
            })
        end
        
        local function current_weather()
            return Widget.Box({
                vertical = true,
                class_name = "box",
                Widget.Box({
                    Widget.Box({
                        Widget.Icon({
                            icon = "weather-clouds",
                            css = "font-size: 400%;",
                        }),
                    }),

                    Widget.Box({
                        vertical = true,
                        Widget.Label({
                            css = "font-size: 300%; font-weight: 600;",
                            label = ((weather_data.current.temperature_2m or "N/A") .. "°C")
                        }),
                        Widget.Label({
                            label = ("Code: " .. (weather_data.current.weather_code or "N/A"))
                        })
                    }),
                }),

                Widget.Box({
                    Widget.Box({
                        vertical = true,
                        class_name = "box",
                        Widget.Icon({
                            icon = "nil",
                        }),
                        Widget.Label({
                            label = ((weather_data.current.relative_humidity_2m or "N/A") .. "%")
                        })
                    }),

                    Widget.Box({
                        vertical = true,
                        class_name = "box",
                        Widget.Icon({
                            icon = "temperature-normal",
                        }),
                        Widget.Label({
                            label = ((weather_data.current.apparent_temperature or "N/A") .. "°C")
                        })
                    }),

                    Widget.Box({
                        vertical = true,
                        class_name = "box",
                        Widget.Icon({
                            icon = "weather-windy",
                        }),
                        Widget.Label({
                            label = ((weather_data.current.wind_speed_10m or "N/A") .. "km/h")
                        })
                    }),
                })
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
                        label = string.format("%d:00", i - 1),
                    }),
                    Widget.Icon({
                        icon = "weather-clouds",
                    }),
                    Widget.Label({
                        label = ((weather_data.hourly.temperature_2m[i] or "N/A") .. "°C")
                    }),
                })
            end

            for i = 1, 24 do 
                h_forecasts[#h_forecasts + 1] = h_forecast(i) 
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

            setup = function(self)
                w_config.date = GLib.DateTime.new_now_local():format("%Y-%m-%d")
                return true
            end,
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
