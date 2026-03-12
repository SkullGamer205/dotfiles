local gears = require("gears")
local enum = require("cuteful.enum")

local conf = {
    -- misc --
    tasklist_show_all                  = false,

    -- pointer config --
    cursor_size                        = 20,
    cursor_inactive_timeout            = 5000,
    cursor_edge_threshold              = 32,
    cursor_edge_snapping_overlay_color = { 0.1, 0.2, 0.3, 0.05 },

    -- keyboard config --
    repeat_rate                        = 30,
    repeat_delay                       = 200,
    -- xkb_variant                        = "colemak",
    -- xkb_layout                         = "us,de,fr",
    -- xkb_options                        = "grp:alt_shift_toggle,grp:caps_select",
    xkb_layout                         = "us,ru",
    xkb_options                        = "grp:alt_shift_toggle",

    -- client config --
    default_decoration_mode            = enum.decoration_mode.SERVER_SIDE,
    border_width                       = 2,
    border_color_rotation              = 0,
    border_color_focus                 = gears.color("#ffffff"),
    border_color_normal                = gears.color("#808080"),
    border_color_raised                = gears.color("#ff0000"),

    -- screen/tag config --
    useless_gaps                       = 4,
}

return conf
