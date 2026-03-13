#!/usr/bin/env bash

CONFIG="$HOME/.config/waybar/config"

# Obtener margen actual (si existe)
current=$(grep '"margin-top"' "$CONFIG" | grep -o '[0-9]\+' | head -n1)
[ -z "$current" ] && current=0

# Elegir nuevo margen
choice=$(printf "0\n5\n10\n15\n20\n25\n30" | \
  rofi -dmenu -p "Waybar Margin (Current: $current px)")

[ -z "$choice" ] && exit 0

# Validar número
if [[ "$choice" =~ ^[0-9]+$ ]]; then

    # Si ya existen los margins → reemplazar
    if grep -q '"margin-top"' "$CONFIG"; then
        sed -i "s/\"margin-top\": *[0-9]\+,/\"margin-top\": $choice,/" "$CONFIG"
        sed -i "s/\"margin-left\": *[0-9]\+,/\"margin-left\": $choice,/" "$CONFIG"
        sed -i "s/\"margin-right\": *[0-9]\+,/\"margin-right\": $choice,/" "$CONFIG"
    else
        # Si no existen → agregarlos después de "height"
        sed -i "/\"height\"/a\  \"margin-top\": $choice,\n  \"margin-left\": $choice,\n  \"margin-right\": $choice," "$CONFIG"
    fi

    # Reiniciar Waybar
    pkill waybar
    waybar &
fi
