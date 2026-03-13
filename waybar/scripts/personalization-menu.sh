#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

choice=$(printf "Waybar\nKitty\nCava Colors\nHyprland\nFastfetch\nBack" | rofi -dmenu -p "Personalization")

case "$choice" in
  Waybar)
    "$SCRIPT_DIR/waybar-menu.sh"
    ;;
  "Kitty")
    "$SCRIPT_DIR/kitty-menu.sh"
    ;;
  "Cava Colors")
    "$HOME/.config/hypr/scripts/cava-colors-menu.sh"
    ;;
  "Hyprland")
    "$SCRIPT_DIR/hyprland-menu.sh"
    ;;
  "Fastfetch")
    "$SCRIPT_DIR/fastfetch-menu.sh"
    ;;
  Back)
    "$SCRIPT_DIR/settings-menu.sh"
    ;;
  *)
    exit 0
    ;;
esac
