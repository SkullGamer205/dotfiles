#!/bin/sh
status=$(mpc status | grep 'random: on')

if [ -n "$status" ]; then
  mpc random off
  dunstify --appname=mpd "Music Player Demon" --raw_icon="$HOME/.icons/oomox-AAA_upscayl_4x_realesrgan-x4plus-anime/16x16/categories/mpd.svg" "▶️ Случайный режим выключен"
else
  mpc random on
  dunstify --appname=mpd "Music Player Demon" --raw_icon="$HOME/.icons/oomox-AAA_upscayl_4x_realesrgan-x4plus-anime/16x16/categories/mpd.svg" "🎲 Случайный режим включен"
fi
