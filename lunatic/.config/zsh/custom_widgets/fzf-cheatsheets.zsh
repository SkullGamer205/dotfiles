{
    fzf-cheatsheets-widget() {
        local cmd=$(echo "${LBUFFER}" | awk '{print $1}')
        local query=$(echo "${LBUFFER}" | awk '{for (i=2; i<NF; i++) print $i " "; if (NF > 1) {print $NF}}')
        local custom_sheet=$(cat "$HOME/Documents/favorite-cmds" | fzf --height 23 --header "Favorites" | cut -d '#' -f2-)
        local selected

        if [ -z "${cmd}" ]; then
            selected="$custom_sheet"
        else
            selected="$custom_sheet"
        fi

        local ret=$?
        if [ $ret -eq 0 ]; then
            LBUFFER="$selected"
        else
            echo "$selected" 1>&2
        fi
        zle reset-prompt
        return $ret
    }

    zle -N fzf-cheatsheets-widget
    bindkey '^X^P' fzf-cheatsheets-widget
}

