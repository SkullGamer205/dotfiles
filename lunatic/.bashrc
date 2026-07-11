#If not running interactively, don't do anything
[[ himBHs != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\e[32m\]$ \[\e[0m\]'

### XDG Ninja fixes ###
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export LUA_PATH='/usr/share/lua/5.4/?.lua;/usr/share/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/home/akira25/.local/share/luarocks/share/lua/5.4/?.lua;/home/akira25/.local/share/luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/usr/lib/lua/5.4/?.so;/usr/lib/lua/5.4/loadall.so;./?.so;/home/akira25/.local/share/luarocks/lib/lua/5.4/?.so'
export PATH='/home/akira25/.local/share/luarocks/bin:/home/akira25/.local/share/zinit/polaris/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/akira25/.local/bin:/home/akira25/Applications/usr/bin'
