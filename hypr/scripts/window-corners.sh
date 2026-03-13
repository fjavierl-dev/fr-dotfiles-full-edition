#!/usr/bin/env bash

# Obtener valor actual
current=$(hyprctl getoption decoration:rounding -j 2>/dev/null | grep -o '"int": *[0-9]*' | grep -o '[0-9]*')

# Si no se pudo obtener, poner 0 como fallback
[ -z "$current" ] && current=0

# Mostrar menú 0–9
choice=$(printf "0\n1\n2\n3\n4\n5\n6\n7\n8\n9" | \
  rofi -dmenu -p "Window Corners (Current: $current)")

# Si cancela
[ -z "$choice" ] && exit 0

# Validar que sea número 0-9
if [[ "$choice" =~ ^[0-9]$ ]]; then
    hyprctl keyword decoration:rounding "$choice"
else
    exit 0
fi
