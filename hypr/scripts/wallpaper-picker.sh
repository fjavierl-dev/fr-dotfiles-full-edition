#!/usr/bin/env bash
# Script para seleccionar y poner un wallpaper local en Hyprland
# Funciona solo con swww y cierra cualquier video activo (mpvpaper)

WALLDIR="$HOME/.config/hypr/wallpapers"
STATE="$HOME/.config/hypr/current_wallpaper"
VIDEO_STATE="$HOME/.config/hypr/current_wallpaper_video"

# Crear directorios si no existen
mkdir -p "$WALLDIR"
mkdir -p "$(dirname "$STATE")"

# Abrir picker para seleccionar imagen
CHOICE=$(zenity --file-selection \
    --title="Selecciona un wallpaper" \
    --filename="$WALLDIR/" \
    --file-filter="Imágenes | *.png *.jpg *.jpeg *.webp")

# Si no se seleccionó nada, salir
[ -z "$CHOICE" ] && exit 0

# 🔥 Si había un video guardado, eliminarlo
rm -f "$VIDEO_STATE"

# 🔥 Matar cualquier mpvpaper activo
pkill -f mpvpaper 2>/dev/null

# 🔥 Arrancar swww-daemon si no está corriendo
if ! pgrep -x swww-daemon >/dev/null; then
    swww-daemon &
    # Esperar un segundo para que el daemon se inicialice
    sleep 1
fi

# Guardar la selección
RELATIVE_PATH="${CHOICE#$WALLDIR/}"
echo "$RELATIVE_PATH" > "$STATE"

# 🔥 Aplicar wallpaper con swww
swww img "$CHOICE" --transition-type any
