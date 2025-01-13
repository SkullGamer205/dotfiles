local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local profile_widget = require( ... .. ".profile")
local brightness_widget = require( ... .. ".brightness")
local music_widget = require( ... .. ".music")
local quick_options_widget = require( ... .. ".quick_options")

local CValues = require("ui.wibar.module.dashboard-widget.cvalues")

local workarea = screen.primary.workarea

local dashboard = wibox({
    widget = {
        {
            {
                {
                    fill_space = false,
                    spacing = dpi(2),
                    layout = wibox.layout.fixed.horizontal,
                },
                widget = wibox.container.margin,
            },
	    profile_widget,
	    -- brightness_widget,
	    music_widget,
	    -- quick_options_widget,
	    nil,
            layout = wibox.layout.stack,
        },
        margins = dpi(4),
        widget = wibox.container.margin,
    },
    type = "dock",
    screen = screen.primary,
    visible = false,
    ontop = true,
    width = dpi(CValues.max_dpi),
    height = dpi(CValues.max_dpi),
    border_width = dpi(2),
    border_color = beautiful.fg_focus,
})

awful.placement.top_right(dashboard, {
    honor_workarea = true,
    margins = beautiful.useless_gap * 4,
    offset = dpi(8),
})

awesome.connect_signal("dashboard::toggle", function()
    dashboard.visible = not dashboard.visible
end)

