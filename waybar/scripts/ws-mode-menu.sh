#!/usr/bin/env bash

STATE="$HOME/.config/waybar/state/ws_mode"
mkdir -p "$(dirname "$STATE")"

choice=$(printf "Modo 2x2\nModo Vertical" | rofi -dmenu -p "Modo escritorios")

case "$choice" in
  "Modo 2x2")
    echo grid > "$STATE"
    ;;
  "Modo Vertical")
    echo vertical > "$STATE"
    ;;
esac
