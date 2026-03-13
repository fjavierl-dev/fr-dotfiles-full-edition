#!/usr/bin/env bash
STATE_FILE="$HOME/.config/waybar/state/ws_colors.json"

# Crear archivo inicial si no existe
if [ ! -f "$STATE_FILE" ]; then
  cat <<EOF > "$STATE_FILE"
{
  "active": "#ffffff",
  "inactive": "#888888",
  "hover": "#ff0000",
  "size": 10,
  "border": 2
}
EOF
fi

choice=$(printf "Active\nInactive\nHover\nSize\nBorder\nBack" | rofi -dmenu -p "WS Grid Personalization")

case "$choice" in
  Active)
    color=$(rofi -dmenu -p "Color activo (#rrggbb)")
    jq --arg c "$color" '.active=$c' "$STATE_FILE" > tmp.json && mv tmp.json "$STATE_FILE"
    ;;
  Inactive)
    color=$(rofi -dmenu -p "Color inactivo (#rrggbb)")
    jq --arg c "$color" '.inactive=$c' "$STATE_FILE" > tmp.json && mv tmp.json "$STATE_FILE"
    ;;
  Hover)
    color=$(rofi -dmenu -p "Color hover (#rrggbb)")
    jq --arg c "$color" '.hover=$c' "$STATE_FILE" > tmp.json && mv tmp.json "$STATE_FILE"
    ;;
  Size)
    size=$(rofi -dmenu -p "Tamaño cuadrado (px)")
    jq --argjson s "$size" '.size=$s' "$STATE_FILE" > tmp.json && mv tmp.json "$STATE_FILE"
    ;;
  Border)
    border=$(rofi -dmenu -p "Borde cuadrado (px)")
    jq --argjson b "$border" '.border=$b' "$STATE_FILE" > tmp.json && mv tmp.json "$STATE_FILE"
    ;;
  Back)
    exit 0
    ;;
esac

# Recargar Waybar para aplicar cambios
pkill -USR2 waybar
