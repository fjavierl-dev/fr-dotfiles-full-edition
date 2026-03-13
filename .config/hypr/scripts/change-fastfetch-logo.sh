#!/usr/bin/env bash

CONFIG="$HOME/.config/fastfetch/config.jsonc"

selected=$(zenity --file-selection \
  --title="Select Fastfetch Logo" \
  --file-filter="Images | *.png *.jpg *.jpeg *.webp")

[ -z "$selected" ] && exit 0

sizepx=$(zenity --entry \
  --title="Logo Size (pixels)" \
  --text="Enter size in pixels (example 600x400)" \
  --entry-text="320x200")

[ -z "$sizepx" ] && exit 0

width_px=$(echo "$sizepx" | cut -dx -f1)
height_px=$(echo "$sizepx" | cut -dx -f2)

if ! [[ "$width_px" =~ ^[0-9]+$ ]] || ! [[ "$height_px" =~ ^[0-9]+$ ]]; then
  zenity --error --text="Invalid format. Use WIDTHxHEIGHT"
  exit 1
fi

cell_w=$((width_px / 10))
cell_h=$((height_px / 20))

[ "$cell_w" -lt 10 ] && cell_w=10
[ "$cell_h" -lt 5 ] && cell_h=5

cp "$CONFIG" "$CONFIG.bak"

tmp=$(mktemp)

jq --arg img "$selected" --argjson w "$cell_w" --argjson h "$cell_h" '
.logo = {
  type: "kitty",
  source: $img,
  width: $w,
  height: $h
}
' "$CONFIG" > "$tmp" && mv "$tmp" "$CONFIG"

notify-send "Fastfetch Logo Updated"
