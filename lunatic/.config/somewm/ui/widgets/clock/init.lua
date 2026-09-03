local beautiful = require('beautiful')
local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')

local SimpleBox     = require('module.simple_widgets.box').create_box
local SimplePopup   = require('module.simple_widgets.popup').create
local ClockWidget   = require(... .. '.widget')

local function Time(format)
    -- Make a simple widget
    local time_widget = wibox.widget({
        widget  = wibox.widget.textbox,
        halign  = 'center',
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


return function(s)
    local popup = SimplePopup('clockmenu', {
        main_widget = ClockWidget,
        placement   = ( awful.placement.under_mouse + awful.placement.no_offscreen ),
    })
    
    local widget = SimpleBox(Time('%H\n%M'), {
        bg_main     = beautiful.colors.background_light,
        on_clicked  = { left = function() popup.toggle() end }
    })
   
    return widget
end
