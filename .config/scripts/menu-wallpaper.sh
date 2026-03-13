#!/usr/bin/env bash

option=$(printf "Local\nSteam (Coming Soon)" | rofi -dmenu -p "Wallpaper Selection")

case "$option" in
  "Local")
    ~/.config/hypr/scripts/wallpaper-picker.sh
    ;;
  "Steam (Coming Soon)")
    notify-send "Steam wallpaper aún no implementado"
    ;;
esac
