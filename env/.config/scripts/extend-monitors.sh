#!/bin/bash
# TITLE: Extend monitors

# Get connected monitors
xrandr | grep " connected"
xrandr --output "DP-0" --auto --primary
xrandr --output "HDMI-0" --auto --right-of "DP-0"

# Restart i3 to trickle changes
i3-msg restart
