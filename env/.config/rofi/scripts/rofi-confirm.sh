#!/usr/bin/env bash

CANCEL=" No"
CONFIRM=" Yes"

case "$(echo -e "$CANCEL\n$CONFIRM" | rofi -dmenu -theme powermenu -mesg "Are you sure?")" in
    "$CANCEL")  exit 1;;
    "$CONFIRM") exit 0;;
esac

exit 1
