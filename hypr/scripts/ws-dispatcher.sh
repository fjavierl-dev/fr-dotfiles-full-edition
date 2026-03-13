#!/usr/bin/env bash

STATE_MODE="$HOME/.config/waybar/state/ws_mode"
STATE_COUNT="$HOME/.config/waybar/state/ws_count"
DIR="$1"

# ===== Leer modo y cantidad de workspaces =====
mode="grid"
[ -f "$STATE_MODE" ] && mode=$(cat "$STATE_MODE")

ws_num=4
[ -f "$STATE_COUNT" ] && ws_num=$(cat "$STATE_COUNT")

# ===== Workspace actual =====
CUR=$(hyprctl activeworkspace -j | jq -r '.id // empty')
[ -z "$CUR" ] && exit 0

# ===== Bloqueo modo single =====
if ! grep -q "persistent:true" "$HOME/.config/hypr/workspaces.conf"; then
    exit 0
fi

# ===== FUNCIONES AUXILIARES =====
dispatch() {
    hyprctl dispatch workspace "$1"
    exit 0
}

# ===== MODO LINEAR (fila única) =====
if [ "$mode" = "linear" ] || [ "$mode" = "vertical" ]; then
    case "$DIR" in
        left|up)
            next=$((CUR - 1))
            [ "$next" -lt 1 ] && next="$ws_num"
            dispatch "$next"
            ;;
        right|down)
            next=$((CUR + 1))
            [ "$next" -gt "$ws_num" ] && next=1
            dispatch "$next"
            ;;
    esac
fi

# ===== MODO GRID =====
# Definimos número de columnas dinámicamente
cols=4  # máximo de columnas por fila
rows=$(( (ws_num + cols - 1) / cols ))  # filas necesarias

# Calcular posición actual (fila, columna)
cur_row=$(( (CUR - 1) / cols ))
cur_col=$(( (CUR - 1) % cols ))

case "$DIR" in
    left)
        new_col=$((cur_col - 1))
        new_row=$cur_row
        if [ $new_col -lt 0 ]; then
            new_col=$((cols - 1))
            new_row=$((cur_row - 1))
            [ $new_row -lt 0 ] && new_row=$((rows - 1))
        fi
        ;;
    right)
        new_col=$((cur_col + 1))
        new_row=$cur_row
        if [ $new_col -ge $cols ]; then
            new_col=0
            new_row=$((cur_row + 1))
            [ $new_row -ge $rows ] && new_row=0
        fi
        ;;
    up)
        new_row=$((cur_row - 1))
        new_col=$cur_col
        [ $new_row -lt 0 ] && new_row=$((rows - 1))
        ;;
    down)
        new_row=$((cur_row + 1))
        new_col=$cur_col
        [ $new_row -ge $rows ] && new_row=0
        ;;
esac

# Calcular el nuevo workspace basado en fila/columna
new_workspace=$(( new_row * cols + new_col + 1 ))

# Ajuste si excede ws_num
[ $new_workspace -gt $ws_num ] && new_workspace=$ws_num

dispatch "$new_workspace"
