local awful = require('awful')

--- Global mouse bindings
awful.mouse.append_global_mousebindings({
   awful.button(nil, 3, function() require('ui.menu') MainMenu:toggle() end),
   awful.button(nil, 4, awful.tag.viewprev),
   awful.button(nil, 5, awful.tag.viewnext),
   awful.button(nil, 6, awful.tag.viewprev),
   awful.button(nil, 7, awful.tag.viewnext)
})
