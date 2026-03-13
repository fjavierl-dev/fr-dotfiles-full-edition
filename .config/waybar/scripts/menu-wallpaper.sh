#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

option=$(printf "Local (no animated)\nLocal (animated)\nSteam (Coming Soon)" | rofi -dmenu -p "Wallpaper Selection")

case "$option" in
  "Local (no animated)")
    ~/.config/hypr/scripts/wallpaper-picker.sh
    ;;
  "Local (animated)")
    "$SCRIPT_DIR/wallpaper-video.sh"
    ;;
  "Steam (Coming Soon)")
    notify-send "Steam wallpaper aún no implementado"
    ;;
esac
