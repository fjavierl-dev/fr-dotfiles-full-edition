#!/usr/bin/env bash
SCRIPT_DIR="$(dirname "$0")"


option=$(printf "Keybindings\nPersonalization\nWorkspaces\nWallpaper Selection\nChange Rofi Theme\nAbout" | rofi -dmenu -p "Settings")

case "$option" in
  Keybindings)
  "$SCRIPT_DIR/keybindings-menu.sh"
    ;;
  Personalization)
   "$SCRIPT_DIR/personalization-menu.sh"
    ;;
  "Workspaces")
    "$SCRIPT_DIR/menu-workspaces.sh"
    ;;
  "Wallpaper Selection")
    "$SCRIPT_DIR/menu-wallpaper.sh"
    ;;
  "Change Rofi Theme")
    "$SCRIPT_DIR/rofi-theme-selector.sh"
    ;;
"About")
    "$SCRIPT_DIR/menu-about.sh"
    ;;
esac
