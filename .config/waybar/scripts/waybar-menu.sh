#!/usr/bin/env bash
# Waybar Personalization Menu
# Llama a otros scripts de configuración de Waybar

SCRIPT_DIR="$(dirname "$0")"

# Menú principal
choice=$(printf "Position\nSize\nWaybar Margin\nBlur\nOpacity\nBack" | rofi -dmenu -p "Waybar")

case "$choice" in
  "Position")
    bash "$SCRIPT_DIR/waybar-position.sh"
    ;;
  "Size")
    bash "$SCRIPT_DIR/waybar-height.sh"
    ;;
  "Waybar Margin")
    bash "$SCRIPT_DIR/waybar-margin.sh"
    ;;
  "Blur")
    bash "$SCRIPT_DIR/waybar-blur.sh"
    ;;
  "Opacity")
    bash "$SCRIPT_DIR/waybar-transparency.sh"
    ;;
  "Back")
    bash "$SCRIPT_DIR/personalization-menu.sh"
    ;;
  *)
    exit 0
    ;;
esac
