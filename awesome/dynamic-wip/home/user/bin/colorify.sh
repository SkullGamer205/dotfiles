#!/bin/bash
# Theme manager
XDG_DATA_HOME="$HOME/.local/share"
THEME_DIR="$XDG_DATA_HOME/themes"
ICONS_DIR="$XDG_DATA_HOME/icons"
COLORS_DIR="$XDG_DATA_HOME/flavours/base16/schemes/"
BASE16_DIR="$XDG_DATA_HOME/base16-templates"
WAL_DIR="$HOME/media/wallpapers"

colorify_help() {
    echo "Colorify: Simple bash script for change Base16 colors everywhere
OIOA"
    exit
}

colorify_rofi_col() {
    flavours list | tr ' ' '\n' | rofi -dmenu -i -show-icons
}

colorify_rofi_wal() {
    fd --full-path "$WAL_DIR" | rofi -dmenu -i -show-icons > "$HOME/.lastwal"
}

colorify_base() {
    echo "[FLAVOURS] Applying a theme"
    flavours -v apply $(colorify_rofi_col)
    echo "[FLAVOURS] Apllied\n"
}

colorify_gen() {
    echo "[FLAVOURS] Generating a theme"
    flavours -v generate "$GEN_TYPE" "$(colorify_rofi_wal)"
    echo "[FLAVOURS] Generated\n"
    echo "[FLAVOURS] Applying a theme"
    flavours -v apply generated
    echo "[FLAVOURS] Apllied"
}

colorify_notify() {
    zenity --class="Colorify" --name="Colorify" --title="AwesomeWM" --window-icon="$XDG_DATA_HOME/icons/oomox-xresources/16x16/actions/clock.svg" --width=128 --height=32 --ok-label="" --info --text "Пожалуйста подождите..." --icon-name="clock" --no-wrap --no-markup --ellipsize
}

colorify_gtk_and_icons() {
    echo "[OOMOX] Generating GTK theme"
    "$BASE16_DIR/themes/oomox/change_color.sh" -d true -t "$THEME_DIR" "$BASE16_DIR/colors/xresources/xresources"
    echo "[OOMOX] Generating icons"
    "$BASE16_DIR/icons/papirus/change_color.sh" -d "$ICONS_DIR/oomox-xresources/" "$BASE16_DIR/colors/xresources/xresources" 
}

colorify_apply_by_colorscheme() {
    colorify_notify &
    colorify_base  &&
    colorify_gtk_and_icons &&
    shuf -en1 media/wallpapers/$(cat "$XDG_DATA_HOME/flavours/lastscheme")/* > "$HOME/.lastwal"
    feh --bg-fill "$(cat $HOME/.lastwal)"
    echo "Done."
    pkill zenity &&
    awesome-client 'awesome.restart()'
}

colorify_apply_by_wallpaper() {
    colorify_notify &
    colorify_gen  &&
    colorify_gtk_and_icons &&
    feh --bg-fill "$(cat $HOME/.lastwal)"
    echo "Done."
    pkill zenity &&
    awesome-client 'awesome.restart()'
}

case "$1" in
    "-f") colorify_apply_by_colorscheme; exit;;
    "-gd") GEN_TYPE="dark"; colorify_apply_by_wallpaper; exit;;
    "-gl") GEN_TYPE="light"; colorify_apply_by_wallpaper; exit;;
    "-h") colorify_help; exit;;
esac
