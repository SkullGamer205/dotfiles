local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()

return function(s)
   return wibox.widget({
	 {
       widget = wibox.widget.textclock,
       format = " %Y年%m月%d日 | %H:%M:%S ",
       fg = xrdb.color3,
       refresh = "0.5",
--       font = "Ark Pixel 10px Monospaced latin 14",
--    buttons = {
--        awful.button({}, 1, nil, function()
--            awesome.emit_signal("clock::toggle")
--        end),
--    },
	 },
	 fg = beautiful.fg_focus,
	 widget = wibox.container.background,
   })
end
