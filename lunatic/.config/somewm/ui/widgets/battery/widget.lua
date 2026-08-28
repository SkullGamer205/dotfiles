-- Battery
local wibox         = require('wibox')
local beautiful     = require('beautiful')
local awful         = require('awful')

local SimpleIcon    = require('module.simple_widgets.image').create_icon
local SimpleBox     = require('module.simple_widgets.box').create_box

local function main_battery_widget()
    local bat_icon  = SimpleIcon(beautiful.battery_full, {
        width = 64,
    })

    local bat_percentage = wibox.widget({
        widget  = wibox.widget.textbox,
        halign  = 'center',
        valign  = 'center',
        text    = '100%',
        font    = beautiful.font:match('[a-zA-Z ]+') .. beautiful.font:match('%d+$') * 2
    })

    local widget = wibox.widget({
        layout  = wibox.layout.fixed.vertical,
        bat_icon,
        bat_percentage,
    })

    return SimpleBox(widget, {
        main_color      = beautiful.colors.background_light,
    })
end

local function battery_stats()
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
            main_color      = beautiful.colors.background_light,
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
        return wibox.widget({
        widget          = wibox.container.background,
        bg              = beautiful.bg_normal,
        border_color    = beautiful.border_color_active,
        border_width    = beautiful.border_width,
        {
            layout  = wibox.layout.fixed.horizontal,
            main_battery_widget(),
            battery_stats(),
        }
    })
end
