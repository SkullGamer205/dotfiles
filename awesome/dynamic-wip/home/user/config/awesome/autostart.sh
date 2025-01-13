#!/bin/bash

###################################################################################################################
###################################################################################################################
###                                                                                                             ###
###                                                                                                             ###
###    MMP"""""""MM                                                           M""MMM""MMM""M M"""""`'"""`YM     ###
###    M' .mmmm  MM                                                           M  MMM  MMM  M M  mm.  mm.  M     ###
###    M         `M dP  dP  dP .d8888b. .d8888b. .d8888b. 88d8b.d8b. .d8888b. M  MMP  MMP  M M  MMM  MMM  M     ###
###    M  MMMMM  MM 88  88  88 88ooood8 Y8ooooo. 88'  `88 88'`88'`88 88ooood8 M  MM'  MM' .M M  MMM  MMM  M     ###
###    M  MMMMM  MM 88.88b.88' 88.  ...       88 88.  .88 88  88  88 88.  ... M  `' . '' .MM M  MMM  MMM  M     ###
###    M  MMMMM  MM 8888P Y8P  `88888P' `88888P' `88888P' dP  dP  dP `88888P' M  `' . '' .MM M  MMM  MMM  M     ###
###    MMMMMMMMMMMM                                                           MMMMMMMMMMMMMM MMMMMMMMMMMMMM     ###
###                                                                                                             ###
###                                                                       Автор конфигурации: SkullGamer205     ###
###################################################################################################################
###################################################################################################################
##
##        \          |              |              |   
##       _ \   |   | __|  _ \   __| __|  _` |  __| __| 
##      ___ \  |   | |   (   |\__ \ |   (   | |    |   
##    _/    _\\__,_|\__|\___/ ____/\__|\__,_|_|   \__| 
##                                                     

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}
rpicom(){
  prime picom
}
# setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle 

exec "$HOME/.bin/mpd-launch" &
run mpd-mpris
run lxqt-policykit-agent
run greenclip daemon
run syncthing-gtk -m
run nitrogen --restore
run conky -d -c $HOME/.config/conky/default
run easystroke --config-dir "/home/$(whoami)/.config/easystroke/"
run rpicom


