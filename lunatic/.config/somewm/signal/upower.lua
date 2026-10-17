-- Libs
local gears     = require("gears")
local debugger  = require("module.debugger")
local helpers   = require("module.simplify.utils.helpers")

local timer = nil

local battery = {
    devices   = {},
    daemons   = {},
}

-- Table map
local battery_map = {
    ["Device"]    = battery.devices,
    ["Daemon"]    = battery.daemons,
}

-- Get/Update function
local function update()
    -- Clean table
    for _, t in pairs(battery) do
        for k in pairs(t) do t[k] = nil end
    end

    -- Execute command
    local cmd = helpers.popen_return("LC_ALL=C upower -d")
    if not cmd then
        debugger.error("UPower", "Command not executed")
        return
    end

    local device, in_section, in_subsection

    -- Get list of devices
    for line in cmd:gmatch('[^\r\n]*') do
        local type, path = line:match('^(%w+):%s*(.*)')
        if type then
            local current_type  = battery_map[type]
            if current_type then
                device          = {}
                in_section      = "main"
                in_subsection   = nil
                current_type[path == "" and type or path] = device
            else
                in_section      = nil
            end
        elseif in_section then
            -- Found a new subsection
            local subsection    = line:match('^%s%s+([%w%s%(%)%-]+)%s*$')
            if subsection then
                in_section      = subsection:lower():gsub(' ', '_'):gsub('%p', '')
                in_subsection   = {}
                device[in_section] = in_subsection
            else
                -- Key-value parsing
                local key, value
                if in_subsection then
                    key, value = line:match('^%s%s%s%s+([^:]+):%s*(.*)')
                else
                    key, value = line:match('^%s%s+([^:]+):%s*(.*)')
                end

                -- Assing values to subsection or main device
                 if key then
                     key = key:match('^%s*(.-)%s*$'):lower():gsub(' ', '_')
                     value = value:gsub("^['\"](.*)['\"]$", '%1')

                     if in_subsection then
                         in_subsection[key]  = value
                     else
                         device[key]         = value
                     end
                 end
            end
        end
    end

    awesome.emit_signal('upower::updated', battery)
    debugger.debug("UPower", "Updated")
end

-- Signals
awesome.connect_signal("upower::update", update)

-- Main function
local function main()
    if not timer then
        timer   = gears.timer({
            timeout     = 30,
            autostart   = true,
            call_now    = true,
            callback    = function()
                awesome.emit_signal("upower::update", true)
            end,
        })
    end
end

main()

return {
    stats   = battery,
    update  = update,
    init    = main
}
