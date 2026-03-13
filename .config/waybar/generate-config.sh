#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

LAYOUT="$HOME/.config/hyprpanel/waybar-layout.json"
TEMPLATE="$REPO_ROOT/waybar/config.template"
OUTPUT="$HOME/.config/waybar/config"

LEFT=$(jq -c '.left' "$LAYOUT")
CENTER=$(jq -c '.center' "$LAYOUT")
RIGHT=$(jq -c '.right' "$LAYOUT")

mkdir -p "$HOME/.config/waybar"

sed \
  -e "s|__LEFT__|$LEFT|" \
  -e "s|__CENTER__|$CENTER|" \
  -e "s|__RIGHT__|$RIGHT|" \
  "$TEMPLATE" > "$OUTPUT"

pkill -USR2 waybar 2>/dev/null
