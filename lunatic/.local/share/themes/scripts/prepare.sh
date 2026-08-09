#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

get_theme() {
    local xdg_theme="$HOME/.local/share/themes"
    local target_dir="$xdg_theme/$theme_name"
    local copy_dir="$xdg_theme/$theme_name_old"
    local tmp_dir="/tmp/$src"

    # If theme exists
    if [ -d "$target_dir" ]; then
        echo "[WARN] '$target_dir' already exists. Skip"
        return 0
    fi
    
    echo "[INFO] installing $src ..."

    # If theme's copy exists
    if [ -d "$copy_dir" ]; then
        echo "[WARN] '$copy_dir' exists. Copying"
        cp -r "$copy_dir" "$target_dir"
        return 0
    fi

    # helpful function 
    install_from_tmp() {
        if [ ! -d "$tmp_dir" ]; then
            echo "[ERROR] Theme path '$tmp_dir' not found in /tmp. Check repo structure."
            return 1
        fi

        echo "[INFO] Copying themes from /tmp ..."
        cp -r "$tmp_dir/$theme_dir/$theme_name_old" "$copy_dir"
        
        echo "[INFO] Making 'Dynamic' theme '$theme_name' ..."
        cp -r "$copy_dir" "$target_dir"
        
        echo "[INFO] Cleaning up /tmp cache ..."
        rm -rf "$tmp_dir"
    }

    # If "/tmp/$src" exists
    if [ -d "$tmp_dir" ]; then
        echo "[INFO] Found sources in /tmp. Installing from there."
        install_from_tmp
        return $?
    fi

    # If it didn't exist
    echo "[INFO] Downloading sources from GitHub ..."
    if git clone --depth 1 "https://github.com/$src" "$tmp_dir"; then
        install_from_tmp
    else
        echo "[ERROR] Failed to clone repository 'https://github.com/$src'"
        return 1
    fi
}

patch_theme() {
    theme_dir="$HOME/.local/share/themes/$theme_name"
    src_dir="$theme_dir/.src"
    echo "[INFO] Patching $theme_name ..."
    echo "[INFO] Copying icons into '.src' directory ..."


    declare -a components=("gtk-2.0" "gtk-3.0" "gtk-4.0" "xfwm4" "metacity-1" "openbox-3")
    declare -a source_files=("gtkrc" "gtk.css" "gtk.css" "themerc" "metacity-theme-1.xml" "themerc")

    for i in "${!components[@]}"; do
        component="${components[$i]}"
        source_file="${source_files[$i]}"
        mustache_file="${component}-base16.mustache"
        palette_patch="${component}-palette.patch"
        base16_patch="${component}-base16.patch"

        directory="$theme_dir/$component"
        template_dir="$theme_dir/templates"
        patch_dir="$SCRIPT_DIR/patches/$theme_name"
        # Check if directory exists
        if [ ! -d "$directory" ]; then
            echo "[WARN] '$component' not found in '$theme_name'. Skip"
            continue
        fi
        
        if [ ! -d "$template_dir" ]; then
            mkdir -p "$template_dir"
        fi
    
        # Check if mustache file already exists
        if [ -f "$template_dir/$mustache_file" ]; then
            echo "[WARN] '$mustache_file' found in '$template_dir'. Skip"
            continue
        fi

        # Create Backup
        if [ ! -f "$directory/${source_file}.old" ]; then
            echo "[INFO] Creating backup file ..."
            cp "$directory/$source_file" "$directory/${source_file}.old"
        fi
        
        # Apply Palette scheme patch (Add Base16 colors on somewhere && patch to use them)
        echo "$patch_dir/$palette_patch"
        if [ -n "$component" ] && [ -f "$patch_dir/$palette_patch" ]; then
            echo "[INFO] Patching '$directory/$source_file'"
            patch "$directory/$source_file" "$patch_dir/$palette_patch"
        fi

        # Create mustache file
        echo "[INFO] Create mustache file '$template_dir/$mustache_file'"
        cp "$directory/$source_file" "$template_dir/$mustache_file"
        patch "$template_dir/$mustache_file" "$patch_dir/$base16_patch" 
    done

    # Copy Icons
    if [ ! -d "$src_dir" ]; then
        find "$theme_dir" -type f -regextype posix-extended -iregex '.*\.(png|jpg|jpeg|gif|xpm)' | while IFS= read -r file; do
            # Get relative path
            relative_path="${file#$theme_dir/}"

            # Create destination_dir
            dest_file="$src_dir/$relative_path"
            dest_subdir="$(dirname "$dest_file")"

            mkdir -p "$dest_subdir"
            cp "$file" "$dest_file"
        done
    else
        echo "[WARN] '.src' directory exists. Skip."
    fi

    # Patching Icons
    # Make color palette
    echo "[INFO] Creating a theme palette ..."
    palette_file="$theme_dir/palette.xpm"
    # magick -size 1x1 $(printf 'xc:%s ' $palette) +append "$palette_file"
    printf "$palette" | head -n 16 | awk '
    BEGIN {
        print "/* XPM */"
        print "static char * palette[] = {"
        print "/* columns rows colors chars-per-pixel */"
        print "\"16 1 16 1 \","
        split("abcdefghijklmnop", chars, "")
    }
    {
        print "\"" chars[NR] " c " $1 "\","
        pixels = pixels chars[NR]
    }
    END {
        print "/* pixels */"
        print "\"" pixels "\""
        print "};"
    }' > "$palette_file"

    export SCRIPT_DIR palette_file

    echo "[INFO] Converting to '.xpm' ... "
    find "$src_dir" -type f -regextype posix-extended -iregex '.*\.(png|jpg|jpeg|gif|xpm)' -print0 | \
        parallel -0 --jobs 50% --halt soon,fail=1 '
            # Stage 1: Convert to xpm
            "$SCRIPT_DIR/convert.sh" --xpm "$palette_file" {}
            # Stage 2: Clean
            "$SCRIPT_DIR/convert.sh" --clean {}
        '

    echo "[INFO] Converting to template ... "

    find "$src_dir" -type f -name '*.xpm' -print0 | \
        parallel -0 --jobs 50% --halt soon,fail=1 '
            # Stage 3: Convert to template
            "$SCRIPT_DIR/convert.sh" --template "$palette_file" {}
        '

    echo "[INFO] Done"
}

Nashville96() {
    src=donfaustinocortizone/Nashville96
    theme_name_old='Nashville96-Gruvbox'
    theme_name='Nashville96-Dynamic'
    theme_dir='Themes'
    palette='#1D2021
    #282828
    #3C3836 
    #504945 
    #bdae93
    #ebdbb2
    #fbf1c7
    #f9f5d7
    #FB4934 
    #FE8019 
    #FABD2F 
    #B8BB26 
    #8EC07C 
    #83A598 
    #D3869B 
    #D65D0E'
    get_theme
    patch_theme
}

Miami26() {
    src=dhampirave/Miami26/tree/Miami26
    theme_name_old='Miami26'
    theme_name='Miami26-Dynamic'
    theme_dir='Themes'
    palette='#161617
    #1B1B1C
    #282829
    #333335
    #5B5B5D
    #DADADA
    #606060
    #8C8C8C

    #FA5252
    #FF922B
    #FFD43B
    #94D82D
    #51CF66
    #4DABF7
    #A5D8FF
    #FA5252'
    get_theme
    patch_theme
}

Greymond() {
    src=parhelion22/xfce-theme-greymond
    theme_name_old='Greymond'
    theme_name='Greymond-Dynamic'
    theme_dir='src'
    get_theme
    patch_theme
}

help() {
    echo '      prepare.sh - Utility to install themes and apply some patches to future use (Base16/24).

Usage:
    ./prepare.sh [options]

Options:
    --Nashville96       Install & Convert Nashville96
    --Miami26           Install & Convert Miami26    
    --Raleigh           Install & Convert Raleigh
    --help              Shows this text
    '
}

case "$1" in
    '--Nashville96')    Nashville96 ; exit ;;
    '--Miami26')        Miami26     ; exit ;;
    '--Greymond')       Greymond    ; exit ;;
    '--help')           help        ; exit ;;
    *)                  help        ; exit ;;
esac
