-- SOURCE: streetturtle/awesome-wm-widgets pactl-widget/pactl.lua
local gears     = require('gears')
local spawn     = require('awful.spawn')

local debugger  = require('module.debugger')
local helpers   = require('module.simplify.utils.helpers')

-- Table of current stats
local audio = {
    sinks = {},
    sources = {},
    sink_inputs = {},
    source_outputs = {},
}

-- Table of devices
local audio_map = {
    ["Sink"]            = audio.sinks,
    ["Source"]          = audio.sources,
    ["Sink Input"]      = audio.sink_inputs,
    ["Source Output"]   = audio.source_outputs,
}

local timer = nil

local function update()
    -- Clear audio table
    for _, t in pairs(audio) do
        for k in pairs(t) do t[k] = nil end
    end

    -- Default devices
    local default_sink    = helpers.popen_return('pactl get-default-sink'  ):gsub("\n", "")
    local default_source  = helpers.popen_return('pactl get-default-source'):gsub("\n", "")
    local device, in_section, in_subsection

    -- Get list of devices
    for line in helpers.popen_return('LC_ALL=C pactl list'):gmatch('[^\r\n]*') do
        local type, id  = line:match('^(.-) #(%d+)')
        if type then
            local current_device = audio_map[type]
            if current_device then
                device              = {}
                in_section          = "main"
                in_subsection       = nil
                current_device[id]  = device
            else
                in_section  = nil
            end
        elseif in_section then
            -- Found a new subsection
            local subsection = line:match('^\t(%a+):$')
            if subsection then
                in_section = subsection:lower()
                if in_section == "ports" or in_section == "properties" then
                    device[in_section] = {}
                    in_subsection      = device[in_section]
                else
                    in_subsection      = nil
                end
            else
                -- Key-value parsing
                local key, value
                if in_section == "main" then
                    key, value  = line:match('^\t([^:]+):%s*(.*)')
                elseif in_subsection then 
                    key, value  = line:match('^\t\t([^:=]+)%s*[:=]%s*(.*)')
                end

                -- Assing values to subsection or main device
                if key then
                    key = key:match('^%s*(.-)%s*$'):lower():gsub(' ', '_')
                    if in_section == "properties" then
                        in_subsection[key]      = value:gsub('^"(.*)"$', '%1')
                    else
                        if in_subsection then
                            in_subsection[key]  = value
                        else
                            device[key]         = value
                        end
                    end
                end
                
                -- Get main device
                if in_section == "main" and key == "name" then 
                    device['is_default'] = (value == default_sink or value  == default_source)
                end
            end
        end
    end

    -- Broadcast data to ALL listeners
    awesome.emit_signal('audio::updated', audio)
    debugger.debug("AudioStats", "Updated")
end

local function set_volume(type, device, volume)
    spawn('pactl set-' .. type .. '-volume ' .. device .. ' '.. volume .. '%', false)
end

awesome.connect_signal('audio::update', update)

-- Initialize
local function main()
    -- Auto-update audio info
    if not timer then
        timer = gears.timer({
            timeout     = 10,
            autostart   = true,
            call_now    = true,
            callback    = function()
                awesome.emit_signal("audio::update", true)
            end
        })
    end
end

main()

return {
    stats       = audio,
    update      = update,
    init        = main,
}
