#!/usr/bin/env bash

option=$(printf "Workspaces\nWallpaper Selection\nChange Rofi Theme" | rofi -dmenu -p "Settings")


case "$option" in
  "Workspaces")
    ~/.config/waybar/scripts/menu-workspaces.sh
    ;;
  "Wallpaper Selection")
    ~/.config/waybar/scripts/menu-wallpaper.sh
    ;;
esac
