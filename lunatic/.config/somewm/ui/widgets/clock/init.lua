local beautiful = require('beautiful')
local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')

local SimplifyWidgets   = require('module.simplify.widgets')
local SimpleBox         = SimplifyWidgets.box.create
local SimplePopup       = SimplifyWidgets.popup.create
local SimpleText        = SimplifyWidgets.textbox.colored

local ClockWidget   = require(... .. '.widget')

local function Time(format)
    -- Make a simple widget
    local time_widget = SimpleText({
        align = {'center', 'center'}
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
        main_widget   = ClockWidget,
        placement     = ( awful.placement.under_mouse + awful.placement.no_offscreen ),
        border_width  = beautiful.border_width,
        border_color  = beautiful.border_color_active,
    })
    
    local widget = SimpleBox(Time('%H\n%M'), {
        bg_main     = beautiful.colors.background_light,
        on_clicked  = { left = function() popup.toggle() end }
    })
   
    return widget
end
