#!/bin/sh
sed -i \
         -e 's/#28282d/rgb(0%,0%,0%)/g' \
         -e 's/#f0f0f0/rgb(100%,100%,100%)/g' \
    -e 's/#28282d/rgb(50%,0%,0%)/g' \
     -e 's/#90e3ff/rgb(0%,50%,0%)/g' \
     -e 's/#28282d/rgb(50%,0%,50%)/g' \
     -e 's/#82f3ff/rgb(0%,0%,50%)/g' \
	"$@"
