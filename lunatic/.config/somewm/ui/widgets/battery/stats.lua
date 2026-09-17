local io        = io
local math      = math
local string    = string
local ipairs    = ipairs
local tonumber  = tonumber

local debugger  = require('module.debugger')

local helpers = {
    -- get first line of a file
    first_line = function(path)
        local file, first = io.open(path, "rb"), nil
        if file then
            first = file:read("*l")
            file:close()
        end
        return first
    end,

    -- list directory contents synchronously
    list_dir = function(path)
        local lines = {}
        local file = io.popen("ls -1 " .. path)
        if file then
            for line in file:lines() do
                lines[#lines + 1] = line
            end
            file:close()
        end
        return lines
    end
}

-- local function factory(args)
return function(args)
    args = args or {}
    local pspath    = args.pspath    or "/sys/class/power_supply/"
    local batteries = args.batteries or (args.battery and {args.battery}) or {}
    local ac        = args.ac        or "AC0"

    -- Discover batteries and AC adapter if not explicitly provided
    if #batteries == 0 then
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

    -- Table of current battery information
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
    bat_now.n_capacity    = {}

    -- Core update function
    local function update()
        debugger.debug("BatteryStats", "Updating function")
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
                bat_now.n_perc[i]       = tonumber(helpers.first_line(bstr .. "vapacity")) or
                                            math.floor((energy_now / energy_full) * 100)

                -- Battery health (%)
                if not charge_design    or charge_design == 0 then
                    bat_now.n_capacity[i] = 0
                else
                    bat_now.n_capacity[i] = math.floor((charge_full / charge_design) * 100)
                end

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
            if bat_now.status == "Full" then
                bat_now.perc = 100
                bat_now.time = "00:00"
                bat_now.watt = 0
            else
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
        end

        -- Return updated stats
        return bat_now
    end

    return {
        stats   = bat_now,
        update  = update,
    }
end
