#!/bin/bash
color_grep_template='#([0-9a-fA-F]{3}){1,2}'

palette_checker() {
    # Palette argument checker
    if [ -f "$palette" ]; then
        echo "[INFO] Used palette from '$palette' ... "
    else
        if [[ "$palette" =~ (xc:#([0-9a-fA-F]{3}){1,2} ){16,} ]]; then
            echo "[WARN] Used 'xc' color palette instad file ..."
        else
            echo "[ERROR] No palette found... '$palette' "
            exit 1
        fi
    fi
}

extract_colors() {
    if [ -f "$1" ]; then
        grep -oP '#([0-9a-fA-F]{3}){1,2}\b' "$1"
    else
        echo "$1" | grep -oP '#([0-9a-fA-F]{3}){1,2}\b'
    fi
}

convert_to_xpm() {
    palette="$1"
    shift
    palette_checker

    for file in "$@"; do
        # File checker
        if [ ! -f "$file" ]; then
            echo "[WARN] File not found. Skip"
            continue
        fi

        echo "[INFO] Converting '"${file}"' ..."
        convert "$file" +dither \( +clone -alpha extract \) \ -alpha off -remap ${palette} \ -alpha on -compose CopyAlpha -composite "${file}.xpm"
        exit 0
    done
}

convert_to_pic() {
    for file in "$@"; do
        if [ ! -f "$file" ]; then
            echo "[WARN] File not found. Skip"
            continue
        fi

        convert "$file" "${file%.*}"
    done
}

convert_to_template() {
    palette="$1"
    shift
    palette_checker

    for file in "$@"; do
        if [ ! -f "$file" ]; then
            echo "[WARN] File not found. Skip"
            continue
        fi

    echo "[INFO] Templating '"${file}"' ..."

    local i=0
        extract_colors "$palette" | while read -r color; do
            base_num=$(printf "%02x" $i)

            sed -i "s/${color}/#{{base${base_num}-hex}}/g" "$file"

            ((i++))
        done
    done
}

clean_sources() {
    for file in "$@"; do
        if [ ! -f "$file" ]; then
            echo "[WARN] File not found. Skip"
            continue
        fi
        echo "[INFO] Removing '"${file}"' ..."
        rm "$file"
    done
}

colorize() {
    palette="$1"
    shift
    palette_checker

    for file in "$@"; do
        if [ ! -f "$file" ]; then
            echo "[WARN] File not found. Skip"
            continue
        fi

    echo "[INFO] Colorizing '"${file}"' ..."

    local i=0
        extract_colors "$palette" | while read -r color; do
            base_num=$(printf "%02x" $i)

            sed -i "s/#{{base${base_num}-hex}}/${color}/g" "$file"

            ((i++))
        done
    done
}

help() {
    echo "    convert.sh - Utility to convert pictures (.png, .gif, .jpeg, .jpg and others) from
one colorscheme to other.

Usage:
    ./convert.sh [options] [file]

Options:   
  --xpm <colorscheme_image> <image>             Convert image to '.xpm' format
                                                (better for color editing)

  --pic <image>                                 Convert .xpm images back to original format.   

  --template <colorscheme_image> <image>        Convert .xpm images to Base16/24 template
                                                (for better colorizing)

  --colorize <colorscheme_image> <image>        Convert 'Base16/24' template into colorized
                                                '.xpm' images
        
  --clean <image>                               Delete picture(-s)

  --help                                        Shows this text"
}

case "$1" in
    '--xpm')      convert_to_xpm        "$2" "$3" ; exit ;;
    '--pic')      convert_to_pic        "$2"      ; exit ;;
    '--template') convert_to_template   "$2" "$3" ; exit ;;
    '--clean')    clean_sources         "$2"      ; exit ;;
    '--colorize') colorize              "$2" "$3" ; exit ;;
    '--help')     help                            ; exit ;;
    *)            help                            ; exit ;;
esac


