#!/bin/sh
status=$(mpc status | grep 'single: on')

if [ -n "$status" ]; then
  mpc single off
  dunstify --appname=mpd "Music Player Demon" --raw_icon="$HOME/.icons/oomox-AAA_upscayl_4x_realesrgan-x4plus-anime/16x16/categories/mpd.svg" "▶️ Одиночный режим выключен️"
else
  mpc single on
  dunstify --appname=mpd "Music Player Demon" --raw_icon="$HOME/.icons/oomox-AAA_upscayl_4x_realesrgan-x4plus-anime/16x16/categories/mpd.svg" "🔂 Одиночный режим включен"
fi
