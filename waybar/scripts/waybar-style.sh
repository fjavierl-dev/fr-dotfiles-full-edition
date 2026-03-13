#!/usr/bin/env bash

STYLE_DIR="$HOME/.config/waybar/styles"
WAYBAR_STYLE="$HOME/.config/waybar/style.css"

# Menú de selección
style_choice=$(printf "Full Bar\nPills Style\nBack" | rofi -dmenu -p "Select Style")

case "$style_choice" in
  "Full Bar")
    cp "$STYLE_DIR/style-full.css" "$WAYBAR_STYLE"
    ;;
  "Pills Style")
    cp "$STYLE_DIR/style-pills.css" "$WAYBAR_STYLE"
    ;;
  "Back")
    bash "$(dirname "$0")/waybar-menu.sh" # O el nombre de tu script principal
    exit 0
    ;;
  *)
    exit 0
    ;;
esac

# Reiniciar Waybar para aplicar cambios
killall waybar
waybar &
