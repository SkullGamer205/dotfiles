#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

build_theme() {
    xdg_theme="$HOME/.local/share/themes"
    theme_dir="$xdg_theme/$theme_name"
    palette_file="$theme_dir/palette.xpm"

    extract_colors
    convert_to_pic
}

extract_colors() {
    color_file="$theme_dir/gtk-3.0/gtk.css"
    echo "[INFO] grabbing color palette from gtk-3.0.css ..."
    if [ -f "$color_file" ]; then
        palette=$(grep -oP "#([0-9a-fA-F]{3}){1,2}\b" "$color_file")
        printf "$palette"
        convert +append -size 1x1 \"$(printf 'xc:%s ' $palette)\" "$palette_file"
    fi
}

convert_to_pic() {
    local src_dir="$theme_dir/.src"
    local assets_dir="$theme_dir/.assets"

    export SCRIPT_DIR palette_file

    echo "[INFO] Converting xpm templates to picture ..."
    cp -r "$src_dir" "$assets_dir"

    find "$assets_dir" -type f -name '*.xpm' -print0 | \
        parallel -0 --jobs 50% --halt soon,fail=1 '
            # Stage 4: Convert templates to pictures
            "$SCRIPT_DIR/convert.sh" --colorize       "$palette_file" {}
            # "$SCRIPT_DIR/convert.sh" --pic                            {}

            # Stage 5: Clean
            # "$SCRIPT_DIR/convert.sh" --clean {}
    '

    echo "[INFO] Move icons"
    cp -r "$assets_dir"/* "$theme_dir"

    echo "[INFO] Move icons"
    # rm -r "$assets_dir"
}

Nashville96() {
    theme_name='Nashville96-Dynamic'
    build_theme
}

Raleigh() {
    theme_name="Raleigh-Dynamic"
    build_theme
}

help() {
    echo '      build.sh - Utility to build theme (convert images & apply colors).

Usage:
    ./build.sh [options]

Options:
    --Nashville96       Build Nashville96
    --Raleigh           Build Raleigh
    --help              Shows this text
    '
}

case  "$1" in
    '--Nashville96') Nashville96 ; exit ;;
    '--Raleigh') Raleigh         ; exit ;;
    '--help') help               ; exit ;;
    *) help                      ; exit ;;
esac
