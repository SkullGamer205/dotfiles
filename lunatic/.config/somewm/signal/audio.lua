-- SOURCE: streetturtle/awesome-wm-widgets pactl-widget/pactl.lua
local gears     = require('gears')
local spawn     = require('awful.spawn')

local debugger  = require('module.debugger')
local helpers   = require('module.simplify.utils.helpers')

-- Table of current stats
local audio = {
    modules = {},
    sinks = {},
    sources = {},
    sink_inputs = {},
    source_outputs = {},
    clients = {},
    cards = {},
}

local timer = nil

local function update()
    -- Table of stats (needed of safely export to main table)
    local audio_now = {
        modules = {},
        sinks = {},
        sources = {},
        sink_inputs = {},
        source_outputs = {},
        clients = {},
        cards = {} ,
    }
    
    local modules         = audio_now.modules
    local sinks           = audio_now.sinks
    local sources         = audio_now.sources
    local sink_inputs     = audio_now.sink_inputs
    local source_outputs  = audio_now.source_outputs
    local clients         = audio_now.clients
    local cards           = audio_now.cards
    
    -- Default device
    local default_sink    = helpers.popen_return('pactl get-default-sink'  )
    local default_source  = helpers.popen_return('pactl get-default-source')

    local device, ports, key, value
    local in_section      = nil

    for line in helpers.popen_return('LC_ALL=C pactl list'):gmatch('[^\r\n]*') do

        -- Check new device block
        local is_module         = string.match(line, '^Module #')
        local is_sink           = string.match(line, '^Sink #')
        local is_source         = string.match(line, '^Source #')
        local is_sink_input     = string.match(line, '^Sink Input #')
        local is_source_output  = string.match(line, '^Source Output #')
        local is_client         = string.match(line, '^Client #')
        local is_card           = string.match(line, '^Card #')

        if is_module or is_sink or is_source or is_sink_input or is_source_output or is_client or is_card then
            local id = line:match('#(%d+)')
            in_section = "main"
            device = {}

            if is_module then
                modules[id] = device
            elseif is_sink then
                sinks[id] = device
                device.is_default = false
            elseif is_source then
                sources[id] = device
                device.is_default = false
            elseif is_sink_input then
                sink_inputs[id] = device
            elseif is_source_output then
                source_outputs[id] = device
            elseif is_client then
                clients[id] = device
            elseif is_card then
                cards[id] = device
            end
        elseif in_section then
            -- Found a new subsection
            local in_subsection = line:match('^\t(%a+):$')
            if in_subsection then
                in_section = in_subsection:lower()
                if in_section == 'ports' then
                    ports = {}
                    device['ports'] = ports
                elseif in_section == 'properties' then
                    properties = {}
                    device['properties'] = properties
                end
            else
                -- Found a 1-st level key-value pair
                local key, value = line:match('^\t([^:]+):%s*(.*)')
                if key and in_section == "main" then
                    key = key:match('^%s*(.-)%s*$'):lower():gsub(' ', '_')
                    device[key] = value

                    if key == "name" and (value == default_sink or value == default_source) then
                        device['is_default'] = true
                    end

                -- Found 2-nd level key-value pair (Ports; Properties)
                elseif in_section == "ports" then
                    local key, value = line:match('^\t\t([^:]+):%s*(.*)')
                    if key then
                        key = key:match('^%s*(.-)%s*$')
                        ports[key] = value
                    end

                elseif in_section == "properties" then
                    local key, value = line:match('^\t\t([^=]+)%s*=%s*(.*)')
                    if key then
                        key = key:match('^%s*(.-)%s*$')
                        value = value:gsub('^"(.*)"$', '%1')
                        properties[key] = value
                    end
                end
            end
        end
    end
    
    -- Sync
    audio = audio_now

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
