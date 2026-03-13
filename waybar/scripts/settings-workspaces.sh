#!/usr/bin/env bash

STATE="$HOME/.config/waybar/state/ws_mode"
mkdir -p "$(dirname "$STATE")"

current="desconocido"
[ -f "$STATE" ] && current=$(cat "$STATE")

choice=$(printf "Cambiar modo (actual: %s)\nVolver" "$current" | rofi -dmenu -p "Workspaces")

case "$choice" in
  "Cambiar modo"*)
    ~/.config/waybar/scripts/ws-mode-menu.sh &
    ;;
esac
