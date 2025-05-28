#!/bin/bash

# Options
options=" Lock\n⏾ Suspend\n Reboot\n Shutdown\n Logout"

# Rofi command with theme (customizable)
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power" -theme ~/.config/rofi/powermenu.rasi)

case "$chosen" in
" Lock") i3lock -c 000000 ;;
"⏾ Suspend") systemctl suspend ;;
" Reboot") systemctl reboot ;;
" Shutdown") systemctl poweroff ;;
" Logout") i3-msg exit ;;
esac
