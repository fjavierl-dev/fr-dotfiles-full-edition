
nano ~/.config/hypr/scripts/ws-vertical.sh


#!/usr/bin/env bash

# Obtener workspace actual de forma segura
current=$(hyprctl activeworkspace -j 2>/dev/null | jq -r '.id // empty')

# Si está vacío, salir sin romper nada
[ -z "$current" ] && exit 0

case "$1" in
  up|left)
    next=$((current - 1))
    ;;
  down|right)
    next=$((current + 1))
    ;;
  *)
    exit 0
    ;;
esac

# wrap 1–4
if [ "$next" -lt 1 ]; then
  next=4
elif [ "$next" -gt 4 ]; then
  next=1
fi

hyprctl dispatch workspace "$next"

