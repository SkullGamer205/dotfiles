#!/bin/sh
# Music Player Daemon Controller
# Made by Yaroslav Levkin
# A.K.A SkullGamer205

mpc_single=$(mpc status | grep 'single: on')
mpc_repeat=$(mpc status | grep 'repeat: on')
mpc_random=$(mpc status | grep 'random: on')
mpc_consume=$(mpc status | grep 'consume: on')
mpc_play=$(mpc status | grep -E 'playing')
mpc_paused=$(mpc status | grep -E 'paused')
mpc_working=$(mpc status | grep -E 'playing|paused')

mpc_paused_cmd="$(mpc current)\n$(mpc status | grep -E "paused" | cut -c 11-48)"
mpc_playing_cmd="$(mpc current)\n$(mpc status | grep -E "playing" | cut -c 11-48)"
mpc_volume=$(mpc status | grep -E "volume:" | cut -c 8-12)

function mpc_notify () {
  notify-send --app-name=mpd 'Music Player Daemon' --icon=$HOME/.icons/oomox-AAA_upscayl_4x_realesrgan-x4plus-anime/16x16/categories/mpd.svg --urgency=normal --category='Music Player Daemon' "$@"
}

mpdc_single () {
if [ -n "$mpc_single" ]; then
  mpc single off
  mpc_notify "▶️ Одиночный режим выключен️"
else
  mpc single on
  mpc_notify "🔂 Одиночный режим включен"
fi
}

mpdc_repeat () {
if [ -n "$mpc_repeat" ]; then
  mpc repeat off
  mpc_notify "▶ Повтор выключен"
else
  mpc repeat on
  mpc_notify "🔁 Повтор включен"
fi
}

mpdc_random () {
if [ -n "$mpc_random" ]; then
  mpc random off
  mpc_notify "▶️ Случайный режим выключен"
else
  mpc random on
  mpc_notify "🎲 Случайный режим включен"
fi
}

mpdc_consume () {
if [ -n "$mpc_consume" ]; then
  mpc consume off
  mpc_notify "▶️ Режим удаления после проигрывания выключен"
else
  mpc consume on
  mpc_notify "🗑️ ️Режим удаления после проигрывания включен"
fi
}

mpdc_toggle () {
if [ -n "$mpc_play" ]; then
  mpc pause
  mpc_notify "⏸️ [На паузе]\n$mpc_paused_cmd"
elif [ -n "$mpc_paused" ]; then
  mpc play
  mpc_notify "▶️ [Играет]\n$mpc_playing_cmd"
else
  mpc play
  mpc_notify "▶️ [Запущен]"
fi
}

mpdc_stop() {
if [[ $mpc_working =~ "paused" ]] || [[ $mpc_working =~ "playing" ]]; then
  mpc_notify "⏹️ [Остановлен]"
  mpc stop
elif ! [[ $mpc_working =~ "paused" ]] || ! [[ $mpc_working =~ "playing" ]]; then
  mpc_notify "⏹️ [Уже остановлен]"
  mpc stop
fi
}

mpdc_now() {
  mpc_notify "$(mpc -f 'Играет: %artist% - %title% \nФайл: ./%file%')"
}

mpdc_next() {
  mpc next
  mpc_notify "⏭️ [Следующий трек]\n$mpc_playing_cmd"
}

mpdc_prev() {
  mpc next
  mpc_notify "⏮️ [Предыдущий трек]\n$mpc_playing_cmd"
}

mpdc_volup() {
  mpc volume +5 && mpc_notify "🔊 Громкость: $mpc_volume"
}

mpdc_voldown() {
  mpc volume -5 && mpc_notify "🔊 Громкость: $mpc_volume"
}

case "$1" in
    "--single") mpdc_single; exit ;;
    "--repeat") mpdc_repeat; exit ;;
    "--random") mpdc_random; exit ;;
    "--consume") mpdc_consume; exit ;;
    "--toggle") mpdc_toggle; exit ;;
    "--stop") mpdc_stop; exit ;;
    "--now") mpdc_now;exit ;;
    "--next") mpdc_next;exit ;;
    "--prev") mpdc_prev;exit ;;
    "--volup") mpdc_volup;exit ;;
    "--voldown") mpdc_voldown;exit ;;
esac
