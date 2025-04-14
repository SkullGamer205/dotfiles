local awful = require('awful')
local gears = require("gears")
local player_commands = {
   {
      description = "  │ Текущий трек",
      pattern = {'n'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --now") end
   },
   {
      description = "  │ Перключить проигрывание",
      pattern = {'p'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --toggle") end
   },
   {
      description = "  │ Остановить плеер",
      pattern = {'S'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --stop") end
   },
   {
      description = "  │ Предыдущий трек",
      pattern = {'h'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --prev") end
   },
   {
      description = "  │ Следующий трек",
      pattern = {'l'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --next") end
   },
   {
      description = "  │ Переключить режим повтора",
      pattern = {'r'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --repeat") end
   },
   {
      description = "  │ Переключить случайный режим",
      pattern = {'d'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --random") end
   },
   {
      description = "  │ Переключить одиночный режим",
      pattern = {'s'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --single") end
   },
   {
      description = "  │ Переключить режим очистки",
      pattern = {'e'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --consume") end
   },
   {
      description = "  │ Уменьшить громкость",
      pattern = {'j'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --voldown") end
   },
   {
      description = "  │ Увеличить громкость",
      pattern = {'k'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --volup") end
   },
   {
      description = "  │ [ROFI] Список текущих треков",
      pattern = {'i'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --currenttracks") end
   },
   {
      description = "  │ [ROFI] Список всех треков",
      pattern = {'o'},
      handler = function () awful.spawn(gears.filesystem.get_configuration_dir() .."scripts/mpc/mpd.sh --alltracks") end
   },
  {
    pattern = {'i'},
    handler = function(mode) mode.stop() end
  },
}

return player_commands
