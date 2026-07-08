local wibox = require('wibox')
local gears = require('gears')

local function Time(format)
    -- Make a simple widget
    local time_widget = wibox.widget({
        widget  = wibox.widget.textbox,
        align   = 'center',
        valign  = 'center',
        text    = '',
    })

    -- Update function
    local function update_func()
        time_widget:set_text('' .. os.date(format))
    end

    -- Timer to trigger update function
    gears.timer({
        timeout     = 1,
        autostart   = true,
        call_now    = true,
        callback    = update_func,
    })

    -- return widget
    return time_widget
end
    
return function()
    return Time('%H\n%M\n%S')
end
