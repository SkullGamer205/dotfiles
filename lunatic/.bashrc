# If not running interactively, don't do anything
[[  himBHs != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\e[32m\]$ \[\e[0m\]'

### XDG Ninja fixes ###
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
