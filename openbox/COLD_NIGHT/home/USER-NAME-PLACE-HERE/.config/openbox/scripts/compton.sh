#!/bin/bash
#
# Start a composition manager.
# (xcompmgr in this case)

comphelp() {
    echo "Composition Manager:"
    echo "   (re)start: COMP"
    echo "   stop:      COMP -s"
    echo "   query:     COMP -q"
    echo "              returns 0 if composition manager is running, else 1"
    exit
}

checkcomp() {
    pgrep compton
}

stopcomp() {
    checkcomp && killall compton
}

startcomp() {
    stopcomp
    killall xcompmgr &
    compton -o.75 -l-15 -I.075 -O.075 -O.075 -f -i.9 --no-fading-destroyed-argb &
    exit
}

case "$1" in
    "")   startcomp ;;
    "-q") checkcomp ;;
    "-s") stopcomp; exit ;;
    *)    comphelp ;;
esac
