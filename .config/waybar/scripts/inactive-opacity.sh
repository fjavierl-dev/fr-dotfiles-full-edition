#!/usr/bin/env bash

CONFIG="$HOME/.config/hypr/hyprland.conf"

# Menú de opciones de opacidad
choice=$(printf "100%%\n90%%\n80%%\n70%%\n60%%\n50%%\n40%%\n30%%\n20%%\n10%%\n0%%" | \
    rofi -dmenu -p "Inactive Opacity")

# Salir si no se eligió nada
[ -z "$choice" ] && exit 0

# Convertir a valor decimal
case "$choice" in
    "100%") opacity="1.0" ;;
    "90%")  opacity="0.9" ;;
    "80%")  opacity="0.8" ;;
    "70%")  opacity="0.7" ;;
    "60%")  opacity="0.6" ;;
    "50%")  opacity="0.5" ;;
    "40%")  opacity="0.4" ;;
    "30%")  opacity="0.3" ;;
    "20%")  opacity="0.2" ;;
    "10%")  opacity="0.1" ;;
    "0%")   opacity="0.0" ;;
esac

# Ver si ya existe la línea y reemplazarla
if grep -q "^\s*inactive_opacity" "$CONFIG"; then
    sed -i "s/^\s*inactive_opacity.*/\tinactive_opacity = $opacity/" "$CONFIG"
else
    # Insertamos dentro del bloque decoration
    sed -i "/^decoration\s*{/a \ \ inactive_opacity = $opacity" "$CONFIG"
fi

# Recargar Hyprland para aplicar cambios
hyprctl reload
