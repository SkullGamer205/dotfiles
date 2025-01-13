#!/usr/bin/env bash
#
# this script allows taking screenshots of the desktop
#
# dependencies: rofi, scrot/grim, slurp/flameshot/spectacle/xfce4-screenshooter

ROFI_CMD="${ROFI_CMD:-rofi -dmenu -i}"
SCREENSHOT_NAME="${SCREENSHOT_NAME:-%Y-%m-%d--%H-%M-%S.png}"
SCREENSHOT_PATH="$HOME/media/screenshots/$SCREENSHOT_NAME"

    notify_name="Scrot"
    notify_title="Скриншот сохранён:"
    notify_msg="[$SCREENSHOT_PATH]"
    notify_btn="Открыть скриншот"



# check for available programs working in both wayland and x11
declare -a programs=("flameshot" "spectacle")

# launch program if found on system
for cmd in "${programs[@]}"; do
    if command -v "$cmd" &> /dev/null; then
        if [ "$cmd" = "flameshot" ]; then
            flameshot launcher
        else
            $cmd
        fi
        exit 0
    fi
done

if [ -n "$WAYLAND_DISPLAY" ]; then
    # fallback on grim
    if ! command -v grim &> /dev/null
    then
        rofi -e "Install grim or a screenshot program for wayland."
        exit 1
    fi

screen_notify() {
notify_action="$(notify-send -a "$notify_name" "$notify_title" "$SCREENSHOT_PATH" -i "$SCREENSHOT_PATH" --action="open=$notify_btn")"
    if [[ "$notify_action" == "open" ]]; then
        feh "$SCREENSHOT_PATH"
    fi
}
    

    screen_cmd() {
        sleep 1 ; grim "$(xdg-user-dir )/media/screenshots/$SCREENSHOT_NAME" ; screen_notify
    }

    area_cmd() {
        grim -g "$(slurp)" "$(xdg-user-dir )/media/screenshots/$SCREENSHOT_NAME" ; screen_notify
    }

    window_cmd() {
        grim -g "$(slurp)" "$(xdg-user-dir )/media/screenshots/$SCREENSHOT_NAME" ; screen_notify
    }
elif [ -n "$DISPLAY" ]; then
    # try xfce4-screenshoter
    if command -v "xfce4-screenshooter" &> /dev/null; then
        xfce4-screenshooter
        exit 0
    fi

    # fallback on scrot
    if ! command -v scrot &> /dev/null
    then
        rofi -e "Install scrot or a screenshot program for X11."
        exit 1
    fi

    screen_cmd() {
        sleep 1 ; scrot "$SCREENSHOT_NAME" -e 'mv $f $$(xdg-user-dir )/media/screenshots ; xdg-open $$(xdg-user-dir )/media/screenshots/$f'
    }

    area_cmd() {
        scrot -s "$SCREENSHOT_NAME" -e 'mv $f $$(xdg-user-dir )/media/screenshots ; xdg-open $$(xdg-user-dir )/media/screenshots/$f'
    }

    window_cmd() {
        scrot -s "$SCREENSHOT_NAME" -e 'mv $f $$(xdg-user-dir )/media/screenshots ; xdg-open $$(xdg-user-dir )/media/screenshots/$f'
    }
else
    echo "Error: No Wayland or X11 display detected" >&2
    exit 1
fi

options="Screen\nArea\nWindow"

chosen="$(echo -e $options | $ROFI_CMD -p 'Screenshot')"

case $chosen in
    "Screen")
        screen_cmd
        exit 0;;
    "Area")
        area_cmd
        exit 0;;
    "Window")
        window_cmd
        exit 0;;
esac

exit 1
