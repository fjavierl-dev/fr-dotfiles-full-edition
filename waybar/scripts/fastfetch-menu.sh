#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

choice=$(printf "Change Fastfetch Logo\nChange Fastfetch Style\nBack" | rofi -dmenu -p "Personalization")

case "$choice" in
   "Change Fastfetch Logo")
    ~/.config/hypr/scripts/change-fastfetch-logo.sh
    ;;
   "Change Fastfetch Style")
    ~/.config/hypr/scripts/change-fastfetch-style.sh
    ;;
  Back)
    "$SCRIPT_DIR/personalization-menu.sh"
    ;;
  *)
    exit 0
    ;;
esac
