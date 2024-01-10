#!/bin/sh
DEVNAME="ELAN1203:00 04F3:307A Touchpad"
PROP="Device Enabled"

ENABLED=$(( `xinput list-props "$DEVNAME" | grep "$PROP" | cut -d\: -f 2` ))

if [ $ENABLED = 1 ]; then
  ENABLE=0
  dunstify --appname=Touchpad "Состояние сенсорной панели" "Сенсорная панель выключена"
else
  ENABLE=1
  dunstify --appname=Touchpad "Состояние сенсорной панели" "Сенсорная панель включена"
fi

xinput -set-prop "$DEVNAME" "$PROP" $ENABLE
