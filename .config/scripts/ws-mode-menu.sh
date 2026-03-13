#!/usr/bin/env bash

STATE="$HOME/.config/waybar/state/ws_mode"
mkdir -p "$(dirname "$STATE")"

choice=$(printf "Modo 2x2\nModo 1→2→3→4" | rofi -dmenu -p "Modo escritorios")

case "$choice" in
  "Modo 2x2")
    echo grid > "$STATE"
    ;;
  "Modo 1→2→3→4")
    echo linear > "$STATE"
    ;;
esac
