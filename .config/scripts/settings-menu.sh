#!/usr/bin/env bash

option=$(printf "Workspaces\nWallpaper Selection\nChange Rofi Theme\nAbout" | rofi -dmenu -p "Settings")

case "$option" in
  "Workspaces")
    ~/.config/waybar/scripts/menu-workspaces.sh
    ;;
  "Wallpaper Selection")
    ~/.config/waybar/scripts/menu-wallpaper.sh
    ;;
  "Change Rofi Theme")
    ~/.config/waybar/scripts/rofi-theme-selector.sh
    ;;
"About")
    ~/.config/waybar/scripts/menu-about.sh
    ;;
esac
