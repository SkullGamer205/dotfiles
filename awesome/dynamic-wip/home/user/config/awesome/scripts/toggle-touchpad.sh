#!/bin/sh
DEVNAME="ELAN1203:00 04F3:307A Touchpad"
PROP="Device Enabled"

ENABLED=$(( `xinput list-props "$DEVNAME" | grep "$PROP" | cut -d\: -f 2` ))

if [ $ENABLED = 1 ]; then
  ENABLE=0
  notify-send "Состояние сенсорной панели" "Сенсорная панель выключена" -a "Touchpad"
else
  ENABLE=1
  notify-send "Состояние сенсорной панели" "Сенсорная панель включена" -a "Touchpad"
fi

xinput -set-prop "$DEVNAME" "$PROP" $ENABLE
