#!/usr/bin/env bash

STATE="$HOME/.config/waybar/state/ws_mode"
mkdir -p "$(dirname "$STATE")"

choice=$(printf "Modo 2x2\nModo vertical 1→4" | rofi -dmenu -p "Escritorios")

case "$choice" in
  "Modo 2x2")
    echo grid > "$STATE"
    ;;
  "Modo vertical 1→4")
    echo linear > "$STATE"
    ;;
esac
