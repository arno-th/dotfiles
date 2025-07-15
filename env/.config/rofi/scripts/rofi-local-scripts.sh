#!/bin/bash

SCRIPT_DIR=$HOME/tools/scripts
chosen=$(ls $SCRIPT_DIR | rofi -dmenu -p "Run script:" -theme scripts)
[[ -n "$chosen" ]] && $SCRIPT_DIR/"$chosen"
