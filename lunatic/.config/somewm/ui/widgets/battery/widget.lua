-- Battery
local wibox           = require('wibox')
local beautiful       = require('beautiful')
local awful           = require('awful')
local gears           = require('gears')

local SimpleIcon      = require('module.simple_widgets.image').create_icon
local SimpleBox       = require('module.simple_widgets.box').create_box

local battery_module  = require('stats')

local battery         = battery_module({})

local bat_percentage = wibox.widget({
    widget  = wibox.widget.textbox,
    halign  = 'center',
    valign  = 'center',
    text    = nil,
    font    = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match('%d+$') * 2
})

local function main_battery_widget()
    local bat_icon  = SimpleIcon(beautiful.battery_full, {
        width = 64,
    })

    local widget = wibox.widget({
        layout  = wibox.layout.fixed.vertical,
        bat_icon,
        bat_percentage,
    })

    return SimpleBox(widget, {
        bg_main  = beautiful.colors.background_light,
    })
end

local function secondary_battery_widgets()
    -- Stat box
    local function stat_box(opts)
        opts = opts

        local icon  = SimpleIcon(opts.icon, {
            width = 32,
            main_color = beautiful.fg_normal,
        })

        local text = wibox.widget({
            widget  = wibox.widget.textbox,
            halign  = 'center',
            valign  = 'center',
            text    = opts.text,
            font    = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match('%d+$')
        })

        local widget = wibox.widget({
            layout  = wibox.layout.fixed.vertical,
            icon,
            text,
        })

        return SimpleBox(widget, {
            bg_main  = beautiful.colors.background_light,
        })
    end

    -- Stats
    local health = stat_box({ icon = beautiful.battery_health, text = '100%' })
    local loops  = stat_box({ icon = beautiful.battery_loops , text =   '-1' })
    local volt   = stat_box({ icon = beautiful.battery_volt  , text =  '0.0' })
    local watt   = stat_box({ icon = beautiful.battery_watt  , text = '12.0' })

    local widget = wibox.widget({
        layout          = wibox.layout.grid,
        forced_num_cols = 2,
        forced_num_rows = 2,
        homogeneous     = true,
        expand          = true,
    })
    widget:add_widget_at(health, 1, 1)
    widget:add_widget_at(loops , 1, 2)
    widget:add_widget_at(volt  , 2, 1)
    widget:add_widget_at(watt  , 2, 2)
    
    return widget
end


return function()
    gears.timer({
        timeout     = 30,
        autostart   = true,
        call_now    = true,
        callback    = function()
            local stats             = battery.update()
            bat_percentage.text     = string.format("%s%%", stats.perc)
        end
    })

    return wibox.widget({
        widget          = wibox.container.background,
        bg              = beautiful.bg_normal,
        border_color    = beautiful.border_color_active,
        border_width    = beautiful.border_width,
        {
            layout  = wibox.layout.fixed.horizontal,
            main_battery_widget(),
            secondary_battery_widgets(),
        }
    })
end
