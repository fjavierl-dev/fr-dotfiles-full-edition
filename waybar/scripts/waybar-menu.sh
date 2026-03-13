#!/usr/bin/env bash
# Waybar Personalization Menu

SCRIPT_DIR="$(dirname "$0")"

# Menú principal (Añadimos Style)
choice=$(printf "Layout\nStyle\nPosition\nSize\nWaybar Margin\nWaybar Side Padding\nBlur\nOpacity\nBack" | rofi -dmenu -p "Waybar")

case "$choice" in
  "Layout")
    "$SCRIPT_DIR/waybar-layout.sh"
    ;;
  "Style")
    bash "$SCRIPT_DIR/waybar-style.sh"
    ;;
  "Position")
    bash "$SCRIPT_DIR/waybar-position.sh"
    ;;
  "Size")
    bash "$SCRIPT_DIR/waybar-height.sh"
    ;;
  "Waybar Margin")
    bash "$SCRIPT_DIR/waybar-margin.sh"
    ;;
  "Waybar Side Padding")
    bash "$SCRIPT_DIR/waybar-side-padding.sh"
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
