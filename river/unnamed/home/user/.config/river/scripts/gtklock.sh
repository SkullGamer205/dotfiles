#!/bin/sh
for output in eDP-1 HDMI-A-1
do
    IMAGE="/tmp/gtklock-$output.png"
    grim -o "$output" $IMAGE
    convert $IMAGE -blur 0x3 $IMAGE
    convert $IMAGE -gamma 0.75 $IMAGE
done
wait
exec gtklock "$@"
