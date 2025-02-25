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
    pgrep xcompmgr
}

stopcomp() {
    checkcomp && killall xcompmgr
}

startcomp() {
    stopcomp
    killall picom &
    xcompmgr -c -C -l-15 -t-15 -o.25 -I.075 -O.075 -D.075 -f -F -S &
    exit
}

case "$1" in
    "")   startcomp ;;
    "-q") checkcomp ;;
    "-s") stopcomp; exit ;;
    *)    comphelp ;;
esac
