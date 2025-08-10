local astal     = require("astal")
local Astal     = astal.require("Astal", "3.0")
local Widget    = require("astal.gtk3.widget")
local App       = require("astal.gtk3").App
local Anchor    = Astal.WindowAnchor
local bind      = astal.bind
local Variable  = astal.Variable
local Battery   = astal.require("AstalBattery")

local Debug     = require("lib.debug")
    -- local bat = Battery.get_default() 
    local function getBatteryDevice()
	local upower = Battery.UPower.new()
	if not upower then
		Debug.error("Battery", "Failed to initialize UPower")
		return nil
	end

	local devices = upower:get_devices()
	if not devices then
		Debug.error("Battery", "Failed to get battery devices")
		return nil
	end

	for _, device in ipairs(devices) do
		if device:get_is_battery() and device:get_power_supply() then
			return device
		end
	end

	local display_device = upower:get_display_device()
	if not display_device then
		Debug.error("Battery", "No battery device found")
		return nil
	end
	return display_device
end


local BatteryInfoMain = function(bat)
    local bat_icon = function(b)
        return Widget.Icon({
            name = "BattryIcon",
            css = "font-size: 64px;",
            icon = bind(b, "battery-icon-name"),
        })
    end

    local bat_label = function(b)
        return Widget.Label({
            name = "BatteryLabel",
            css = "font-size: 22px; font-weight: bold;",
            label = bind(b, "percentage"):as(
                function(p) return tostring(math.floor(p * 100)).."%" end
            ),
        })
    end

    return Widget.Box({
        class_name = "boy_bat_l",
        vertical = true,
        bat_icon(bat),
        bat_label(bat),
    })
end

local BatteryInfoSub = function(bat)
    local bat_state = Variable.derive({ bind(bat, "state") }, function(state)
        if not state then
            return "Unknown"
        end
        return state:gsub("^%l", string.upper):gsub("-", " ")
    end)

    local bat_capacity = Variable.derive({ bind(bat, "capacity") }, function(capacity)
        if not capacity then
            return "N/A"
        end
        return string.format("%.1f%%", capacity * 100)
    end)

    local bat_cycles = bind(bat, "charge-cycles"):as(function(cycles)
        return tostring(cycles or "N/A")
    end)

    local bat_rate = bind(bat, "energy-rate"):as(function(rate)
        if not rate then
            Degub.error("Battery", "Failed to get power draw rate")
            return "N/A"
        end
        return string.format("%.1f W", rate)
    end)
    
    local bat_voltage = bind(bat, "voltage"):as(function(voltage)
        if not voltage then
            Debug.error("Battery", "Failed to get battery voltage")
            return "N/A"
        end
        return string.format("%.1f V", voltage)
    end)

    return Widget.Box({
        class_name = "boy_bat_r",
        vertical = true,
        Widget.Box({
            hexpand = true,
            class_name = "box_bat_status",
            Widget.Label({label = "Статус:"}),
            Widget.Label({
                label = bind(bat_state),
                xalign = 1,
                hexpand = true,
            }),
        }),
        Widget.Box({
            hexpand = true,
            class_name = "box_bat_health",
            Widget.Label({label = "Здоровье:"}),
            Widget.Label({
                label = bind(bat_capacity),
                xalign = 1,
                hexpand = true,
            }),
        }),
        Widget.Box({
            hexpand = true,
            class_name = "box_bat_cycles",
            Widget.Label({label = "Циклы зарядки:"}),
            Widget.Label({
                label = bind(bat_cycles),
                xalign = 1,
                hexpand = true,
            }),
        }),
        Widget.Box({
            hexpand = true,
            class_name = "box_bat_rate",
            Widget.Label({label = "Power draw:"}),
            Widget.Label({
                label = bind(bat_rate),
                xalign = 1,
                hexpand = true,
            }),
        }),
        Widget.Box({
            hexpand = true,
            class_name = "box_bat_voltage",
            Widget.Label({label = "Вольтаж:"}),
            Widget.Label({
                label = bind(bat_voltage),
                xalign = 1,
                hexpand = true,
            }),
        })
    })
end

return function()
    local bat = getBatteryDevice()
    if not bat then 
        Debug.error("Battery", "No battery device found")
        return Widget.Box({})
    end

    return Widget.Window({
        name = "BatteryWindow",
        class_name = "win_battery",
        application = App,
        monitor = monitor,
        exclusivity = "NORMAL",
        anchor = Anchor.TOP + Anchor.RIGHT,
        visible = false,
        Widget.Box({
            class_name = "box_bat",
            BatteryInfoMain(bat),
            BatteryInfoSub(bat),
        })
    })
end
