#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="~/.config/awesome/scripts/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-lazy-grab -show drun -modi drun -config $HOME/.config/rofi/rofi.rasi"

# Options
shutdown=" Выключение"
reboot=" Перезапуск"
lock=" Блокировка"
suspend=" Сон"
logout=" Выход"

# Confirmation
confirm_exit() {
	rofi -dmenu\
        -no-config\
		-i\
		-no-fixed-num-lines\
		-p "Ты уверен? [y/n] : "\
		-theme $dir/confirm.rasi
}

# Message
msg() {
	rofi -no-config -theme "$dir/message.rasi" -e "Возможные опции  -  yes / y / no / n / да / д / нет / н"
}

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" || $ans == "да" || $ans == "ДА" || $ans == "д" || $ans == "Д" ]]; then
			loginctl poweroff
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" || $ans == "нет" || $ans == "НЕТ" || $ans == "н" || $ans == "Н" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $reboot)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" || $ans == "да" || $ans == "ДА" || $ans == "д" || $ans == "Д" ]]; then
			loginctl reboot
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" || $ans == "нет" || $ans == "НЕТ" || $ans == "н" || $ans == "Н" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $lock)
		if [[ -f /usr/bin/i3lock ]]; then
			sleep 0.25 && i3lock -B sigma -k --indicator --time-align 1 --date-align 1 --layout-align 1 --time-pos="128:1080-96" --time-color=FFFFFFFF --date-color=FFFFFFFF --layout-color=FFFFFFFF --ind-pos="64:1080-72" --radius 48 --ring-width 4 --keylayout 1 --raw=1920:1080:rgb
		fi
        ;;
    $suspend)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" || $ans == "да" || $ans == "ДА" || $ans == "д" || $ans == "Д" ]]; then
			mpc -q pause
			amixer set Master mute
			sleep 1 && i3lock -B sigma -k --indicator --time-align 1 --date-align 1 --layout-align 1 --time-pos="128:1080-96" --time-color=FFFFFFFF --date-color=FFFFFFFF --layout-color=FFFFFFFF --ind-pos="64:1080-72" --radius 48 --ring-width 4 --keylayout 1 --raw=1920:1080:rgb & loginctl suspend
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" || $ans == "нет" || $ans == "НЕТ" || $ans == "н" || $ans == "Н" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $logout)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" || $ans == "да" || $ans == "ДА" || $ans == "д" || $ans == "Д" ]]; then
			if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
				i3-msg exit
			fi
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" || $ans == "нет" || $ans == "НЕТ" || $ans == "н" || $ans == "Н" ]]; then
			exit 0
        else
			msg
        fi
        ;;
esac
