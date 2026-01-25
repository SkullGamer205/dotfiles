{
    simple_cmd() {
        local cmd=$(echo "${LBUFFER}" | awk '{print $1}')
        local query=$(echo "${LBUFFER}" | awk '{for (i=2; i<NF; i++) print $i " "; if (NF > 1) {print $NF}}')
        local selected

        if [ -z "${cmd}" ]; then
            selected="$1"
        else
            selected="$1"
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

    fzf-cheatsheets-widget() {
        local custom_sheet=$(cat "$HOME/Documents/favorite-cmds" | fzf --height 23 --header "Favorites" | cut -d '#' -f2-)
        simple_cmd $custom_sheet
    }

    tldr-cheatsheets-widget() {
        local tldr_cmd=$(tealdeer --list | fzf --preview "tealdeer {1}" --preview-window=60% --height 25 | xargs tealdeer)
        echo "$tldr_cmd"
        zle reset-prompt
    }

    zle -N fzf-cheatsheets-widget
    zle -N tldr-cheatsheets-widget
    bindkey '^X^P' fzf-cheatsheets-widget
    bindkey '^X^B' tldr-cheatsheets-widget
}

