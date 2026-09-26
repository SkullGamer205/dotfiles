local io        = io
local math      = math
local string    = string
local ipairs    = ipairs
local tonumber  = tonumber

local gears     = require('gears')

local debugger  = require('module.debugger')

local helpers   = require('module.simplify.utils.helpers')

-- Table of current battery stats
local bat_now = {
    status        = "N/A",
    ac_status     = "N/A",
    perc          = "N/A",
    time          = "N/A",
    watt          = "N/A",
    capacity      = "N/A",
}

bat_now.n_status      = {}
bat_now.n_perc        = {}

local ac        = "AC0"
local pspath    = "/sys/class/power_supply/"
local batteries = {}
local timer     = nil

local function get_batteries()
    local lines = helpers.list_dir(pspath)
    for _, line in ipairs(lines) do
        local bstr = string.match(line, "BAT%w+")
        if bstr then
            batteries[#batteries + 1] = bstr
        else
            local ac_match = string.match(line, "A%w+")
            if ac_match then ac = ac_match end
        end
    end
end

local function update()
    -- Summary stats
    local bat_sum = {
        rate_current        = 0,
        rate_voltage        = 0,
        rate_power          = 0,
        rate_energy         = 0,
        energy_now          = 0,
        energy_full         = 0,
        charge_full         = 0,
        charge_design       = 0,
        cycles              = 0,
    }

    for i, battery in pairs(batteries) do
        local bstr      = pspath .. battery
        local present   = helpers.first_line(bstr .. "/present")

        if tonumber(present) == 1 then
            -- current_now(I)[uA], voltage_now(U)[uV], power_now(P)[uW]
            local rate_current      = tonumber(helpers.first_line(bstr .. "/current_now"))          or 0
            local rate_voltage      = tonumber(helpers.first_line(bstr .. "/voltage_now"))          or 0
            local rate_power        = tonumber(helpers.first_line(bstr .. "/power_now"))            or 0
            local rate_energy       = rate_power  or  (((rate_voltage or 0) * (rate_current or 0)) / 1e6)
            
            -- energy_now(P)[uWh], charge_now(I)[uAh]
            local energy_now        = tonumber(helpers.first_line(bstr .. "/energy_now")            or helpers.first_line(bstr .. "/charge_now"))   or 0
            -- energy_full(P)[uWh], charge_full(I)[uAh]
            local energy_full       = tonumber(helpers.first_line(bstr .. "/energy_full")           or helpers.first_line(bstr .. "/charge_full"))  or 0
            local charge_full       = tonumber(helpers.first_line(bstr .. "/charge_full"))          or 0
            local charge_design     = tonumber(helpers.first_line(bstr .. "/charge_full_design"))   or 0
            
            local cycles            = tonumber(helpers.first_line(bstr .. "/cycle_count")) or 0

            bat_now.n_status[i]     = helpers.first_line(bstr .. "/status") or "N/A"
            bat_now.n_perc[i]       = tonumber(helpers.first_line(bstr .. "capacity")) or
                                        math.floor((energy_now / energy_full) * 100)
            
            bat_sum.rate_current    = bat_sum.rate_current  + rate_current
            bat_sum.rate_voltage    = bat_sum.rate_voltage  + rate_voltage
            bat_sum.rate_power      = bat_sum.rate_power    + rate_power
            bat_sum.rate_energy     = bat_sum.rate_energy   + rate_energy
            bat_sum.energy_now      = bat_sum.energy_now    + energy_now
            bat_sum.energy_full     = bat_sum.energy_full   + energy_full
            bat_sum.charge_full     = bat_sum.charge_full   + charge_full
            bat_sum.charge_design   = bat_sum.charge_design + charge_design
            bat_sum.cycles          = bat_sum.cycles        + cycles
        end
    end

        bat_now.rate_current    = bat_sum.rate_current
        bat_now.rate_voltage    = bat_sum.rate_voltage
        bat_now.rate_power      = bat_sum.rate_power  
        bat_now.rate_energy     = bat_sum.rate_energy 
        bat_now.energy_now      = bat_sum.energy_now  
        bat_now.energy_full     = bat_sum.energy_full 
        bat_now.charge_full     = bat_sum.charge_full 
        bat_now.charge_design   = bat_sum.charge_design
        bat_now.cycles          = bat_sum.cycles

        bat_now.capacity = math.min((bat_sum.charge_full / bat_sum.charge_design) * 100)

        -- When one of the battery is charging, others' status are either
        -- "Full", "Unknown" or "Charging". When the laptop is not plugged in,
        -- one or more of the batteries may be full, but only one battery
        -- discharging suffices to set global status to "Discharging".
        bat_now.status = bat_now.n_status[1] or "N/A"
        for _,status in ipairs(bat_now.n_status) do
            if status == "Discharging" or status == "Charging" then
                bat_now.status = status
            end
        end

        -- AC Adapter status
        bat_now.ac_status = tonumber(helpers.first_line(pspath .. ac .. "/online")) or "N/A"

        if bat_now.status ~= "N/A" then
            bat_now.perc = math.floor(math.min(100, (bat_sum.energy_now / bat_sum.energy_full) * 100))
            
            local rate_time = 0
            local div = (bat_sum.rate_power > 0 and bat_sum.rate_power) or bat_sum.rate_current
            if div > 0 then
                if bat_now.status == "Charging" then
                    rate_time = (bat_sum.energy_full - bat_sum.energy_now) / div
                else -- Discharging
                    rate_time = bat_sum.energy_now / div
                end
            end
            
            local hours   = math.floor(rate_time)
            local minutes = math.floor((rate_time - hours) * 60)
            bat_now.time  = string.format("%02d:%02d", hours, minutes)
            
            -- sum_rate_energy is in uW, divide by 1e6 to get Watts
            bat_now.watt  = tonumber(string.format("%.2f", bat_sum.rate_energy / 1e6))
        end


    -- Broadcast data to ALL listeners
    awesome.emit_signal('battery::updated', bat_now)
    debugger.debug("BatteryStats", "Updated")
end

-- Ability to listen for external requests
    -- Force Update
awesome.connect_signal('battery::update', update)

-- Listen for status requests with callback
awesome.connect_signal("battery::status", function(callback)
    debugger.debug("BatteryStats", "Emitted 'status' signal")
    if type(callback) == "function" then
        callback(bat_now)
    end
end)

-- Initialize
local function main()
    if #batteries == 0 then
        get_batteries()
    end

    -- Auto-update battery data at interval
    if not timer then
        timer = gears.timer({
            timeout     = 30,
            autostart   = true,
            call_now    = true,
            callback    = function()
                awesome.emit_signal('battery::update', true)
            end,
        })
    end
end

main()

return {
    stats       = bat_now,
    update      = update,
    init        = main
}
