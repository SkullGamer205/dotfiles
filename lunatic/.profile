### XDG Ninja fixes ###
export PATH="$PATH:$HOME/.local/bin:$HOME/Applications/usr/bin"
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

## XDeb
export XDEB_PKGROOT="$XDG_CONFIG_HOME"/xdeb

## I-Bus
export GTK_IM_MODULE=wayland
export XMODIFIERS=@im=ibus
