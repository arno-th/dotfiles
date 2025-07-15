#!/bin/bash

SCRIPT_DIR=$(dirname $(realpath $0))

LOCK=" Lock"
SLEEP="⏾ Suspend"
LOGOUT=" Logout"
RESTART=" Restart"
SHUTDOWN=" Shutdown"

list_icons() {
    echo $LOCK
    echo $SLEEP
    echo $LOGOUT
    echo $RESTART
    echo $SHUTDOWN
}

handle_option() {
    case "$1" in
        "$LOCK")
            "$HOME/.config/i3/i3lock.sh" $HOME/Pictures/icy-planet-wallpaper.jpg
            ;;
        "$SLEEP")
            if $($SCRIPT_DIR/rofi-confirm.sh); then
                systemctl suspend
            fi
            ;;
        "$LOGOUT")
            if $($SCRIPT_DIR/rofi-confirm.sh); then
                i3-msg exit
            fi
            ;;
        "$RESTART")
            if $($SCRIPT_DIR/rofi-confirm.sh); then
                systemctl reboot
            fi
            ;;
        "$SHUTDOWN")
            if $($SCRIPT_DIR/rofi-confirm.sh); then
                systemctl poweroff
            fi
            ;;
    esac
}

{
    SELECTION="$(list_icons | rofi -dmenu -theme powermenu -p "")"
    handle_option "$SELECTION" &
} &
