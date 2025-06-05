#!/bin/bash

# Get list of connected monitors
monitors=($(xrandr | grep " connected" | awk '{print $1}'))

# Load the currently primary monitor
current_primary=$(xrandr | grep " connected primary" | awk '{print $1}')

# Find index of current primary
for i in "${!monitors[@]}"; do
    if [[ "${monitors[$i]}" = "$current_primary" ]]; then
        current_index=$i
        break
    fi
done

# Calculate next monitor index (wrap around)
next_index=$(((current_index + 1) % ${#monitors[@]}))
next_primary="${monitors[$next_index]}"

# Set new primary monitor
xrandr --output "$next_primary" --primary
