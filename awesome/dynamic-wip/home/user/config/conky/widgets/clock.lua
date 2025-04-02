-- Conky, a system monitor https://github.com/brndnmtthws/conky
--
-- This configuration file is Lua code. You can write code in here, and it will
-- execute when Conky loads. You can use it to generate your own advanced
-- configurations.
--
-- Try this (remove the `--`):
--
   print("Загрузка конфигурации")
--
-- For more on Lua, see:
-- https://www.lua.org/pil/contents.html

conky.config = require("widgets.lib.common").extend_config {
   own_window_class = 'Conky',
   own_window_title = 'conky',
   
   alignment = 'middle_middle',
   gap_x = 16,
   gap_y = 320,

   border_width = 0,
   draw_borders = true,
   extra_newline = true,
   net_avg_samples = 2,
   no_buffers = true,
   temperature_unit = celsius ,
   minimum_height = 32,
   minimum_width = 632,
}

conky.text = [[
${goto 178}$color1$font1${time %H:%M}${color2}$font2${time :%S}
$alignc${color1}${font2}${time %Y年%m月%d日}
]]

-- ⌠ 󰕾 $mpd_vol ⌡$alignr⌠ $if_mpd_playing󰐊$else󰏤$endif ⌡ ⌠ $mpd_elapsed | $mpd_length ⌡
-- $alignc ${scroll left 48 $mpd_smart } 󰎌
--   ⣿ ⌠ $memperc% ⌡ $mem ${goto 256}$alignr ⌠ ${nvidia gputemp}°С ⌡ ⣿ 
--   ⣿ ⌠ $swapperc% ⌡ $swap ${goto 256}$alignr ${freq 0} MHz ⌠ ${cpu cpu0}% ⌡ ⣿ 󰘚
--  :: [$memperc%] $mem
--  :: [$swapperc%] $swap
-- 󰜮 :: ${downspeed wlan0}
-- 󰜷 :: ${upspeed wlan0}
-- 󰘚 :: [${cpu cpu0}%] ${freq 0} MHz
-- 󰔐 :: [${nvidia gputemp}°С]
