  #!/bin/sh
status=$(mpc status | grep 'repeat: on')

if [ -n "$status" ]; then
  mpc repeat off
  dunstify --appname=mpd "Music Player Demon" --raw_icon="$HOME/.icons/oomox-AAA_upscayl_4x_realesrgan-x4plus-anime/16x16/categories/mpd.svg" "▶️ Повтор выключен"
else
  mpc repeat on
  dunstify --appname=mpd "Music Player Demon" --raw_icon="$HOME/.icons/oomox-AAA_upscayl_4x_realesrgan-x4plus-anime/16x16/categories/mpd.svg" "🔁 Повтор включен"
fi
