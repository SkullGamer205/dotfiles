#!/bin/sh
query=$(mpc listall | rofi -dmenu)
if [[ $(mpc) != *paused* || $(mpc) != *playing* ]]; then
mpc play; fi
if [[ $query != "" ]]; then
mpc insert "$query"; mpc next
fi
