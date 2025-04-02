local awful = require('awful')
local gears = require("gears")
local mod    = require('binds.mod')
local modkey = mod.modkey

awful.keyboard.append_global_keybindings({
    -- Music player
    awful.key({ modkey, "Shift"   }, "KP_Left", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --prev") end,
              {description = "Предыдущий трек", group = "Music Player Daemon"}),
    awful.key({ modkey, "Shift"   }, "KP_Right", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --next") end,
              {description = "Следующий трек", group = "Music Player Daemon"}),
    awful.key({ modkey, "Shift"   }, "KP_Begin", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --toggle") end,
              {description = "Перключить проигрывание", group = "Music Player Daemon"}),
    awful.key({ modkey, "Shift"   }, "KP_End", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --repeat") end,
              {description = "Переключить режим повтора", group = "Music Player Daemon"}),
    awful.key({ modkey, "Shift"   }, "KP_Next", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --random") end,
              {description = "Переключить случайный режим", group = "Music Player Daemon"}),
    awful.key({ modkey, "Shift"   }, "KP_Home", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --single") end,
              {description = "Переключить одиночный режим", group = "Music Player Daemon"}),
    awful.key({ modkey, "Shift"   }, "KP_Prior", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --consume") end,
              {description = "Переключить режим удаления после проигрывания", group = "Music Player Daemon"}),
    awful.key({ modkey, "Shift"   }, "KP_Insert", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --now") end,
              {description = "Текущий трек", group = "Music Player Daemon"}),
    awful.key({ modkey, "Shift"   }, "KP_Down", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --voldown") end,
              {description = "Уменьшить громкость", group = "Music Player Daemon"}),
    awful.key({ modkey, "Shift"   }, "KP_Up", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --volup") end,
              {description = "Увеличить громкость", group = "Music Player Daemon"}),
    awful.key({ modkey, "Shift"   }, "KP_Subtract", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --currenttracks") end,
              {description = "[ROFI] Список текущих треков", group = "Music Player Daemon"}),
    awful.key({ modkey, "Shift"   }, "KP_Add", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --alltracks") end,
              {description = "[ROFI] Список всех треков", group = "Music Player Daemon"}),
    awful.key({ modkey, "Shift"   }, "KP_Delete", function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --stop") end,
              {description = "Остановить плеер", group = "Music Player Daemon"}),
})
