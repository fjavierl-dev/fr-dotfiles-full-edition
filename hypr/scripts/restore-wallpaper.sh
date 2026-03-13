#!/usr/bin/env bash

STATE="$HOME/.config/hypr/current_wallpaper"

# esperar a que swww esté listo
sleep 1

if [ -f "$STATE" ]; then
  swww img "$(cat "$STATE")" --transition-type none
fi
