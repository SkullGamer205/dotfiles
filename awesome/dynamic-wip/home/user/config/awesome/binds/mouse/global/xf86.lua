local awful = require('awful')
local gears = require("gears")
local mod    = require('binds.mouse.mod')
local modkey = mod.modkey

awful.keyboard.append_global_keybindings({
    -- Advanced keys
    awful.key({                   }, "XF86TouchpadToggle", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/toggle-touchpad.sh") end,
              {description = "Переключить тачпад", group = "XF86"}),
    awful.key({                   }, "XF86_AudioLowerVolume", function () awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%") end,
              {description = "Уменьшить громкость", group = "XF86"}),
    awful.key({                   }, "XF86_AudioRaiseVolume", function () awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%") end,
              {description = "Увеличить громкость", group = "XF86"}),
    awful.key({                   }, "XF86_AudioMute", function () awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end,
              {description = "Переключить звук", group = "XF86"}),
    awful.key({                   }, "XF86_AudioMicMute", function () awful.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle") end,
              {description = "Переключить микрофон", group = "XF86"}),
    awful.key({                   }, "XF86MonBrightnessDown", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/brightness -D") end,
              {description = "Уменьшить яркость", group = "XF86"}),
    awful.key({                   }, "XF86MonBrightnessUp", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/brightness -I") end,
              {description = "Увеличить яркость", group = "XF86"}),
    awful.key({                   }, "Print", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/scrot.sh -f") end,
              {description = "Снимок экрана", group = "XF86"}),
    awful.key({"Shift"            }, "Print", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/scrot.sh -s") end,
              {description = "Снимок участка экрана", group = "XF86"}),
    awful.key({"Control"          }, "Print", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/scrot.sh -a") end,
              {description = "Снимок активного окна", group = "XF86"}),
})
