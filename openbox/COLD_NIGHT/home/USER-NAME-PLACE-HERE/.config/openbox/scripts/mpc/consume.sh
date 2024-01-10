#!/bin/sh
status=$(mpc status | grep 'consume: on')

if [ -n "$status" ]; then
  mpc consume off
  dunstify --appname=mpd "Music Player Demon" --raw_icon="$HOME/.icons/oomox-AAA_upscayl_4x_realesrgan-x4plus-anime/16x16/categories/mpd.svg" "▶️ Режим удаления после проигрывания выключен"
else
  mpc consume on
  dunstify --appname=mpd "Music Player Demon" --raw_icon="$HOME/.icons/oomox-AAA_upscayl_4x_realesrgan-x4plus-anime/16x16/categories/mpd.svg" "🗑️ ️Режим удаления после проигрывания включен"
fi
