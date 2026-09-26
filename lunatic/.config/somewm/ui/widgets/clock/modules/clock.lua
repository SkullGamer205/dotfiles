-- Libs
local wibox             = require('wibox')
local beautiful         = require('beautiful')
local gears             = require('gears')

local SimplifyWidgets   = require('module.simplify.widgets')
local SimpleBox         = SimplifyWidgets.box.create
local SimpleText        = SimplifyWidgets.textbox.colored

return function(format)

    local clock_widget = SimpleText({
        align = {'center', 'center'},
        font    = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match('%d+$') * 4
    })
    
    local function update_func()
        clock_widget:set_text('' .. os.date(format))
    end

    gears.timer({
        timeout     = 1,
        autostart   = true,
        call_now    = true,
        callback    = update_func,
    })

    return SimpleBox(clock_widget, {
        bg_main = beautiful.colors.background_light,
    })
end
