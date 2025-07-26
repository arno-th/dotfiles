#!/bin/bash

# Directories to search
dirs=(
  "$HOME/tools/scripts"
  "$HOME/.config/scripts"
)

menu_entries=()

# --- Collect titles from scripts ---
for d in "${dirs[@]}"; do
  [ -d "$d" ] || continue
  for f in "$d"/*; do
    [ -f "$f" ] || continue
    # Look for a header line "# TITLE: something"
    title=$(grep -m1 '^# TITLE:' "$f" | sed 's/^# TITLE:[[:space:]]*//')
    if [[ -z "$title" ]]; then
      # no title found, use the file's basename
      title=$(basename "$f")
    fi
    menu_entries+=("$title|$f")
  done
done

# --- Sort alphabetically by title ---
IFS=$'\n' sorted=($(sort <<<"${menu_entries[*]}"))
unset IFS

# Split sorted entries back into titles and paths
titles=()
paths=()
for entry in "${sorted[@]}"; do
  t="${entry%%|*}"
  p="${entry#*|}"
  titles+=("$t")
  paths+=("$p")
done

# --- Show menu ---
choice=$(printf '%s\n' "${titles[@]}" | rofi -dmenu -i -p "Run script:" -theme scripts)
[[ -z "$choice" ]] && exit 0

# --- Execute selected script ---
for i in "${!titles[@]}"; do
  if [[ "${titles[$i]}" == "$choice" ]]; then
    "${paths[$i]}"
    break
  fi
done

