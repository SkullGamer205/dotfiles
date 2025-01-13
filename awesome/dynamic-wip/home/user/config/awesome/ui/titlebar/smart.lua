-- Smart Borders
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
require("module.awesome-smart-borders"){
	show_button_tooltips = false,
    button_positions = { "top" },
	buttons = { "close", "maximize", "minimize", "floating" },
	border_width = 2,
	button_size = 24,
	layout = "fixed",
	stealth = true,
	align_horizontal = "center",
	color_normal = xrdb.color8,
	color_focus = xrdb.foreground,
	
	color_close_normal = xrdb.color1,
	color_close_focus  = xrdb.color1,
	color_close_hover  = xrdb.color9,
	
	color_maximize_normal = xrdb.color3,
	color_maximize_focus = xrdb.color3,
	color_maximize_hover = xrdb.color11,
	
	color_minimize_normal = xrdb.color2,
	color_minimize_focus = xrdb.color2,
	color_minimize_hover = xrdb.color10,
	
	color_floating_normal = xrdb.color5,
	color_floating_focus = xrdb.color5,
	color_floating_hover = xrdb.color13
}
