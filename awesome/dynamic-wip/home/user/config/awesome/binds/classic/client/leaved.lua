local awful  = require('awful')
local gears  = require("gears")
local mod    = require('binds.mod')
local leaved = require('module.awesome-leaved')
local modkey = mod.modkey
if awful.screen.focused().selected_tag.layout.name == "leaved.layout.suit.tile.right" then
   awful.keyboard.append_global_keybindings({
	    awful.key({ modkey, mod.shift }, "t", function () leaved.keys.shiftStyle() end,
	       {description = "Switch shift style", group = "Планировка: Leaved"}),
	       
	    awful.key({ modkey,           }, "o", function () leaved.keys.shiftOrder() end,
	       {description = "shift order", group = "Планировка: Leaved"}),
	    awful.key({ modkey, mod.shift }, "h", function () leaved.keys.splitH() end,
	       {description = "split next horizontal", group = "Планировка: Leaved"}),
	    awful.key({ modkey, mod.shift }, "v", function () leaved.keys.splitV() end,
	       {description = "split next vertical", group = "Планировка: Leaved"}),
	    awful.key({ modkey, mod.shift }, "v", function () leaved.keys.splitOpp() end,
	       {description = "switch orientation of the current container", group = "Планировка: Leaved"}),
	    
	    awful.key({ modkey, mod.shift }, "]", function () leaved.keys.scaleOpposite(-5) end,
	       {description = "Degrease scale opposite", group = "Планировка: Leaved"}),
	    awful.key({ modkey, mod.shift }, "[", function () leaved.keys.scaleOpposite(5) end,
	       {description = "Increase scale opposite", group = "Планировка: Leaved"}),
	    
	    awful.key({ modkey,           }, "]", function () leaved.keys.scaleFocused(-5) end,
	       {description = "Degrease scale focused", group = "Планировка: Leaved"}),
	    awful.key({ modkey,           }, "[", function () leaved.keys.scaleFocused(5) end,
	       {description = "Increase scale focused", group = "Планировка: Leaved"}),
	    
	    
	    awful.key({ modkey,           }, "'", function () leaved.keys.swap() end,
	       {description = "swap active client with another in the tree", group = "Планировка: Leaved"}),
	    awful.key({ modkey,           }, ";", function () leaved.keys.focus_container() end,
	       {description = "Select container", group = "Планировка: Leaved"}),
	    
	    awful.key({ modkey, mod.shift }, "n", function () leaved.keys.min_container() end,
	       {description = "Minimize container", group = "Планировка: Leaved"}),
	    awful.key({ modkey, mod.shift }, "u", function () leaved.keys.select_use_container() end,
	       {description = "Select container", group = "Планировка: Leaved"}),
   })
end
-- client.connect_signal('request::default_mousebindings', function()
--    awful.mouse.append_client_mousebindings({
-- 	 awful.button({ modkey }, 1, function () leaved.mouse.move() end),
-- 	    awful.button({ modkey }, 3, function () leaved.mouse.resize() end)
--    })
-- end)
