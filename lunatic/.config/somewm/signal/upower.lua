-- Libs
local awful     = require("awful")
local gears     = require("gears")
local dkjson    = require("dkjson")
local debugger  = require("module.debugger")

local timer = nil

local battery = {}


-- Get/Update function
local function update()
    local cmd = "upower -d | jc --upower"
    awful.spawn.easy_async_with_shell(cmd, function(stdout, stderr, exitreason, exitcode)
        if exitcode ~= 0 then
            debugger.warn("UPower", string.format("Failed to execute command. Error: %d (%s)", exitcode, exitreason))
        else
            battery = dkjson.decode(stdout)
        end
    end)

    -- Broadcast data to ALL listeners
    awesome.emit_signal('upower::updated', bat_now)
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
