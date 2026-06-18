local awful = require('awful')

-- {{{ Mouse bindings
-- @DOC_ROOT_BUTTONS@
awful.mouse.append_global_mousebindings({
    awful.button({nil}, 3, function () mymainmenu:toggle() end),
    awful.button({nil}, 4, awful.tag.viewprev),
    awful.button({nil}, 5, awful.tag.viewnext),
})
-- }}}

