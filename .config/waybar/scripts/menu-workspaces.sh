#!/usr/bin/env bash
SCRIPT_DIR="$(dirname "$0")"


option=$(printf "Toggle Workspaces\nSwitch Mode\nChange Number of Workspaces\nBack" | rofi -dmenu -p "Workspaces")

case "$option" in
  "Toggle Workspaces")
    "$SCRIPT_DIR/ws-toggle-visibility.sh"
    ;;
  "Switch Mode")
    ~/.config/waybar/scripts/ws-mode.sh
    ;;
  "Change Number of Workspaces")
    "$SCRIPT_DIR/ws-count-menu.sh"
    ;;
  "Back")
    "$SCRIPT_DIR/settings-menu.sh"
    ;;
esac
