#!/usr/bin/env bash
# Script seguro para poner wallpaper animado sin acumular procesos

VIDDIR="$HOME/Vídeos"
STATE="$HOME/.config/hypr/current_wallpaper_video"
mkdir -p "$(dirname "$STATE")"

# Primer monitor disponible
MONITOR=$(hyprctl monitors | grep "Monitor" | awk '{print $2}' | head -n1)

# Abrir picker para seleccionar video
VIDEO=$(zenity --file-selection \
  --title="Selecciona un wallpaper animado" \
  --filename="$VIDDIR/" \
  --file-filter="Videos | *.mp4 *.mkv *.webm")

[ -z "$VIDEO" ] && exit 0

# Guardar selección
echo "$VIDEO" > "$STATE"

# Matar cualquier instancia previa de mpvpaper
pkill -f mpvpaper 2>/dev/null

# Iniciar nuevo wallpaper en loop
mpvpaper "$MONITOR" "$VIDEO" -o "--loop-file=inf" &

notify-send "Wallpaper animado" "Video $VIDEO iniciado correctamente"
