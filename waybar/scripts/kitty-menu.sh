#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

choice=$(printf "Kitty Theme\nKitty Opacity\nKitty Blur ON OFF\nBack" | rofi -dmenu -p "Personalization")

case "$choice" in
  "Kitty Theme")
    "$SCRIPT_DIR/kitty-theme.sh"
    ;;
  "Kitty Opacity")
    "$SCRIPT_DIR/kitty-transparency.sh"
    ;;
  "Kitty Blur ON OFF")
    "$SCRIPT_DIR/kitty-blur.sh"
    ;; 
  Back)
    "$SCRIPT_DIR/personalization-menu.sh"
    ;;
  *)
    exit 0
    ;;
esac
