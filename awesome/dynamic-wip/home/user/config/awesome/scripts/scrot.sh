#!/bin/sh
screen_name="$(date +%F--%H-%M-%S).png"
screen_path="$HOME/media/screenshots/"
screen_full="$screen_path$screen_name"

    notify_name="Scrot"
    notify_title="Скриншот сохранён:"
    notify_msg="[$screen_full]"
    notify_btn="Открыть скриншот"

screen_notify() {
notify_action="$(notify-send -a "$notify_name" "$notify_title" "$notify_msg" -i "$screen_full" --action="open=$notify_btn")"
    if [[ "$notify_action" == "open" ]]; then
        feh "$screen_full"
    fi
}

screen_full() {
scrot $screen_full
screen_copy
screen_notify
}

screen_active() {
scrot -u -b $screen_full
screen_copy
screen_notify
}

screen_area() {
scrot -s -f -i $screen_full
screen_copy
screen_notify
}

screen_copy() {
xclip -selection clipbaord -target image/png -i "$screen_full"
}

case "$1" in
    "-f")    screen_full; exit ;;
    "-a")    screen_active; exit ;;
    "-s")    screen_area; exit ;;
esac
