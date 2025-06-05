#!/bin/sh
# Usage: i3lock.sh /path/to/image

# Color definitions
BLANK='#00000000'
CLEAR='#ffffff22'
MAGENTA='#ff00ffcc'
MAGENTA_DARK='#bb00bbcc'
CYAN='#08c3d4cc'
RED='#880000cc'

if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/image"
    exit 1
fi

IMG="$1"

if [ ! -f "$IMG" ]; then
    echo "Error: File not found: $IMG"
    exit 1
fi

# Get screen resolution
RES=$(xrandr | grep ' connected' |
    sed -nE 's/.* ([0-9]+)x([0-9]+)\+[0-9]+\+[0-9]+.*/\1 \2/p' |
    awk '{w+=$1; if($2>h) h=$2} END{print w"x"h}')

# Get primary screen number
PRIMARY_SCREEN=$(xrandr --listmonitors | awk '/\*/ {print $1}' | sed 's/://')
PRIMARY_SCREEN=$((PRIMARY_SCREEN + 1))

# Cache path
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/i3lock"
mkdir -p "$CACHE_DIR"
CACHE_IMG="$CACHE_DIR/lockscreen-$(basename "$IMG" | md5sum | cut -d' ' -f1)-$RES.png"

# Regenerate if cache missing or outdated
if [ ! -f "$CACHE_IMG" ] || [ "$IMG" -nt "$CACHE_IMG" ]; then
    echo "Generating new lockscreen image for $RES..."
    convert "$IMG" -resize "${RES}^" -gravity center -extent "$RES" "$CACHE_IMG"
else
    echo "Using cached lockscreen image."
fi

# Call the lockscreen
i3lock \
    --insidever-color=$CLEAR \
    --ringver-color=$CYAN \
    \
    --insidewrong-color=$CLEAR \
    --ringwrong-color=$RED \
    \
    --inside-color=$BLANK \
    --ring-color=$MAGENTA \
    --line-color=$BLANK \
    --separator-color=$MAGENTA \
    \
    --verif-color=$CYAN \
    --wrong-color=$MAGENTA \
    --time-color=$MAGENTA \
    --date-color=$MAGENTA \
    --layout-color=$MAGENTA \
    --keyhl-color=$CYAN \
    --bshl-color=$CYAN \
    \
    --image=$CACHE_IMG \
    \
    --clock \
    --time-str="%H:%M:%S" \
    --date-str="%A, %Y-%m-%d" \
    --screen $PRIMARY_SCREEN \
    --ignore-empty-password \
    --indicator \
    --cmd-media-pause \
    \
    --verif-text="Verifying..." \
    --wrong-text="Nope!" \
    --noinput-text="No input..."
