#!/usr/bin/env bash
# Script para activar/desactivar blur de Waybar en Hyprland usando Rofi

HYPRCONF="$HOME/.config/hypr/hyprland.conf"

# Opciones On/Off
OPTIONS=("Off" "On")

# Seleccionar con Rofi
CHOICE=$(printf "%s\n" "${OPTIONS[@]}" | rofi -dmenu -p "Waybar Blur")

# Salir si no se eligió nada
[ -z "$CHOICE" ] && exit 0

# Backup del hyprland.conf
cp "$HYPRCONF" "$HYPRCONF.bak.$(date +%Y%m%d-%H%M%S)"

# Eliminar línea previa de layerrule waybar
sed -i '/^layerrule = match:namespace ^(waybar)/d' "$HYPRCONF"

# Aplicar blur si eligió "On"
if [ "$CHOICE" == "On" ]; then
    echo "layerrule = match:namespace ^(waybar)$, blur 1" >> "$HYPRCONF"
fi

# Recargar Hyprland
hyprctl reload

# Notificación
notify-send "Waybar Blur" "Blur ${CHOICE}d"
