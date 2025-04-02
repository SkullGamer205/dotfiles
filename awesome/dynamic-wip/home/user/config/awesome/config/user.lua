local awful  =  require('awful')
local lain   =  require('module.lain')
local machi  =  require('module.layout-machi')
local leaved =  require('module.awesome-leaved')
local retain = require('module.awesome-retain')
-- Specify user preferences for Awesome's behavior.
return {
   -- Default modkey.
   -- Usually, Mod4 is the key with a logo between Control and Alt. If you do not like 
   -- this or do not have such a key, I suggest you to remap Mod4 to another key using 
   -- xmodmap or other tools. However, you can use another modifier like Mod1, but it 
   -- may interact with others.
   mod  = 'Mod4',
   -- Each screen has its own tag table. You can just define one and append it to all 
   -- screens (default behavior).

   -- Moved to signals
   tags = { '1', '2', '3', '4', '5', '6', '7', '8', },
   
   -- Table of layouts to cover with awful.layout.inc, ORDER MATTERS, the first layout 
   -- in the table is your DEFAULT LAYOUT.
   layouts = {
      machi.default_layout,
      awful.layout.suit.floating,
      awful.layout.suit.max.fullscreen,
      leaved.layout.suit.tile.right,
      awful.layout.suit.tile,
     -- awful.layout.suit.tile.left,
     -- awful.layout.suit.tile.bottom,
     -- awful.layout.suit.tile.top,
     -- awful.layout.suit.fair,
     -- awful.layout.suit.fair.horizontal,
     -- awful.layout.suit.spiral,
     -- awful.layout.suit.spiral.dwindle,
     -- awful.layout.suit.max,
     -- awful.layout.suit.magnifier,
     -- awful.layout.suit.corner.nw,
     -- lain.layout.centerwork,
      awful.layout.suit.magnifier,
     -- lain.layout.centerwork.horizontal, 
   }
}
