#!/usr/bin/env bash

option=$(printf "Switch Mode" | rofi -dmenu -p "Workspaces")

case "$option" in
  "Switch Mode")
    ~/.config/waybar/scripts/ws-mode.sh
    ;;
esac
