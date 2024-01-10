#!/bin/bash

eval "$(ssh-agent -s)" &&
xterm -e "ssh-add /home/skullgamer205/.ssh/SkullGamer205" &&
notify-send -a "Git Connect" -i "/usr/share/icons/gruvbox-icons/categories/scalable/git.svg" "Подключён к Git"
