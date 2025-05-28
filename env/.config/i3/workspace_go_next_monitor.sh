#!/bin/bash

# Get list of connected monitors into a Bash array
readarray -t MONITORS < <(xrandr | grep " connected" | awk '{print $1}')

# Get the currently focused workspace and its output (monitor)
CURRENT_WS=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')
CURRENT_OUTPUT=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .output')

# Find index of current output
CURRENT_INDEX=-1
for i in "${!MONITORS[@]}"; do
    if [[ "${MONITORS[$i]}" == "$CURRENT_OUTPUT" ]]; then
        CURRENT_INDEX=$i
        break
    fi
done

# If we didn't find the output, abort
if [[ "$CURRENT_INDEX" -eq -1 ]]; then
    echo "Current output not found in monitor list"
    exit 1
fi

# Compute next index (wrap around)
NEXT_INDEX=$(((CURRENT_INDEX + 1) % ${#MONITORS[@]}))
NEXT_OUTPUT="${MONITORS[$NEXT_INDEX]}"

# Move the current workspace to the next output
i3-msg "workspace $CURRENT_WS; move workspace to output $NEXT_OUTPUT"
