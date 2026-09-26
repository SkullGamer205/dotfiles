-- Libs
local wibox           = require('wibox')
local beautiful       = require('beautiful')
local awful           = require('awful')
local gears           = require('gears')

-- Simplify
local SimplifyWidgets   = require('module.simplify.widgets')
local SimpleBox         = SimplifyWidgets.box.create
local SimpleIcon        = SimplifyWidgets.icon.create
local SimpleText        = SimplifyWidgets.textbox.colored

-- Template Box
local function box_template(opts)
    opts = opts or {}
    local icon  = SimpleIcon(opts.icon, {
         width = opts.width or 32,
         main_color = opts.color or nil,
     })
    
     local text_widget = SimpleText({
         align   = {'center', 'center'},
         text    = opts.text or 'N/A',
         font    = beautiful.font:match('[a-zA-Z ]+') .. (tonumber(beautiful.font:match('%d+$'))) * (opts.font_size or 1)
     })
      
     local box = SimpleBox({icon, text_widget}, {
         bg_main  = beautiful.colors.background_light,
         align    = "vertical",
     })
     
     return box, text_widget
end

-- Values
local main_box,   main_text   = box_template({ width = 64, font_size = 2, icon = beautiful.battery_full,     text = "N/A%" })
local health_box, health_text = box_template({ icon = beautiful.battery_health, color = beautiful.fg_normal, text = 'N/A%' })
local loops_box,  loops_text  = box_template({ icon = beautiful.battery_loops , color = beautiful.fg_normal, text =  'N/A' })
local volt_box,   volt_text   = box_template({ icon = beautiful.battery_volt  , color = beautiful.fg_normal, text =  'N/A' })
local watt_box,   watt_text   = box_template({ icon = beautiful.battery_watt  , color = beautiful.fg_normal, text =  'N/A' })

local function secondary_battery_widgets()
    -- Stats
    local widget = wibox.widget({
        layout          = wibox.layout.grid,
        forced_num_cols = 2,
        forced_num_rows = 2,
        homogeneous     = true,
        expand          = true,
    })
    widget:add_widget_at(health_box, 1, 1)
    widget:add_widget_at(loops_box , 1, 2)
    widget:add_widget_at(volt_box  , 2, 1)
    widget:add_widget_at(watt_box  , 2, 2)
    
    return widget
end

-- Update function
local function update_stats(stats)
    main_text:set_text(string.format("%d%%"  , stats.perc))
    health_text:set_text(string.format("%.1f%%", stats.capacity))
    loops_text:set_text(string.format("%d"    , stats.cycles))
    volt_text:set_text(string.format("%.2f"  , stats.rate_voltage / 1e6))
    watt_text:set_text(string.format("%.2f"  , stats.watt))
end

-- Listen for global update signals
awesome.connect_signal("battery::updated", update_stats)

return function()
    return wibox.widget({
        widget          = wibox.container.background,
        bg              = beautiful.bg_normal,
        {
            layout  = wibox.layout.fixed.horizontal,
            main_box,
            secondary_battery_widgets(),
        }
    })
end
