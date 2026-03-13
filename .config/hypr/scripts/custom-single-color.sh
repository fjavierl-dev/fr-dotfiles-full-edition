#!/usr/bin/env bash

CSS_FILE="$HOME/.config/waybar/style.css"

# Pedir color
single_color=$(rofi -dmenu -p $'Enter custom color:\n(Example: #3B4A61)')
[ -z "$single_color" ] && exit 0

# Validar formato HEX #RRGGBB
if [[ ! "$single_color" =~ ^#[0-9a-fA-F]{6}$ ]]; then
    rofi -e "Invalid format. Use #RRGGBB"
    exit 0
fi

# Convertir a formato Hyprland rgba(RRGGBBff)
hex="${single_color#\#}"
color_rgba="rgba(${hex}ff)"

# Aplicar a Hyprland
hyprctl keyword general:col.active_border "$color_rgba"

# Aplicar a Waybar
sed -i "/^#waybar[[:space:]]*{/,/}/ s/border:.*;/border: 2px solid $single_color;/g" "$CSS_FILE"

# Reiniciar Waybar
pkill waybar
waybar &
