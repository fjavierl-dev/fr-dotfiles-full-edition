#!/usr/bin/env bash

STATE_MODE="$HOME/.config/waybar/state/ws_mode"
STATE_COUNT="$HOME/.config/waybar/state/ws_count"

# ===== Leer modo y cantidad de workspaces =====
mode="grid"
[ -f "$STATE_MODE" ] && mode=$(cat "$STATE_MODE")

ws_num=4
[ -f "$STATE_COUNT" ] && ws_num=$(cat "$STATE_COUNT")

# ===== Workspace activo =====
active=$(hyprctl activeworkspace -j | jq -r '.id // empty')
[ -z "$active" ] && exit 0

# ===== Símbolos =====
on="⬛"
off="⬜"

ws() {
    [ "$1" -eq "$active" ] && printf "%s" "$on" || printf "%s" "$off"
}

# ===== Generar texto según modo =====
text=""

if [ "$mode" = "vertical" ]; then
    # Modo vertical = fila horizontal única
    for i in $(seq 1 $ws_num); do
        text+=$(ws $i)
    done
else
    # Modo grid: calcular filas y columnas dinámicamente
    # Queremos cuadrado lo más “compacto” posible
    cols=$(( (ws_num + 1) / 2 ))           # mitad redondeada hacia arriba
    rows=$(( (ws_num + cols - 1) / cols )) # número de filas necesario

    for r in $(seq 0 $((rows-1))); do
        for c in $(seq 1 $cols); do
            idx=$(( r*cols + c ))
            [ $idx -le $ws_num ] && text+=$(ws $idx)
        done
        text+="\n"
    done
fi

# ===== Salida JSON para Waybar =====
echo "{\"text\":\"$text\"}"
