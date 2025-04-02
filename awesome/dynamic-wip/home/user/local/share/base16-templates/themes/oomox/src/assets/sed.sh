#!/bin/sh
sed -i \
         -e 's/#%BG%/rgb(0%,0%,0%)/g' \
         -e 's/#%FG%/rgb(100%,100%,100%)/g' \
    -e 's/#%HDR_BG%/rgb(50%,0%,0%)/g' \
     -e 's/#%ACCENT_BG%/rgb(0%,50%,0%)/g' \
     -e 's/#%TXT_BG%/rgb(50%,0%,50%)/g' \
     -e 's/#%TXT_FG%/rgb(0%,0%,50%)/g' \
	"$@"
