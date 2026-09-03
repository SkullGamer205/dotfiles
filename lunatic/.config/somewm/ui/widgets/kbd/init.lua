local wibox      = require('wibox')
local awful      = require('awful')
local beautiful  = require('beautiful')

local SimpleIcon = require('module.simple_widgets.image').create_icon
local SimpleBox  = require('module.simple_widgets.box').create_box

-- Keyboard map indicator and switcher
return function()
    -- Keyboard icon
    local icon               = SimpleIcon(beautiful.keyboard,{
        main_color           = beautiful.fg_normal,
    })

    -- Keyboard text widget
    local kbd_widget  = wibox.widget({
        widget  = wibox.widget.textbox,
        halign  = 'center',
        valign  = 'center',
        markup  = "<i>" .. "N/A" .. "</i>",
    })

    -- Update function
    local function update_kbd()
        local layouts = awful.widget.keyboardlayout.get_groups_from_group_names(awesome.xkb_get_group_names())
        local current = awesome.xkb_get_layout_group() + 1

        if layouts[current] then
            kbd_widget.markup = "<i>" .. (layouts[current].file):upper() .. "</i>"
        end
    end

    local widget = wibox.widget({
        layout   = wibox.layout.fixed.vertical,
        icon,
        kbd_widget,
    })

    -- Switch layout
    local function change_kbd(shift_idx)
        local layouts = (awesome.xkb_get_group_names()):match("%d+$")
        local current = awesome.xkb_get_layout_group()

        local next_idx = (current + shift_idx) % layouts

        awesome.xkb_set_layout_group(next_idx)
        update_kbd()
    end

    -- Connect Signals
    awesome.connect_signal("xkb::map_changed", update_kbd)
    awesome.connect_signal("xkb::group_changed", update_kbd)

    -- First initialization
    update_kbd()

    return SimpleBox(widget, {
        bg_main     = beautiful.colors.background_light,
        on_clicked  = { left = function() change_kbd(1) end }
    })
end
