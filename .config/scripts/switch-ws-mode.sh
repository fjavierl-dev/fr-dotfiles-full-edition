#!/usr/bin/env bash

STATE="$HOME/.config/waybar/state/workspace_mode"

CHOICE=$(zenity --list \
  --title="Cambiar modo de escritorios" \
  --column="Modo" \
  "Cuadrado (2x2)" \
  "Vertical (1-4)")

[ -z "$CHOICE" ] && exit 0

case "$CHOICE" in
  "Cuadrado (2x2)") echo "grid" ;;
  "Vertical (1-4)") echo "vertical" ;;
esac > "$STATE"

pkill waybar
waybar &
