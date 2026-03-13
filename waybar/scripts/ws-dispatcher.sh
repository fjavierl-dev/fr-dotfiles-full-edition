#!/usr/bin/env bash

notify-send "Dispatcher ejecutado" "Dirección: $1"

notify-send "Dispatcher ejecutado" "Dirección: $DIR"

STATE_MODE="$HOME/.config/waybar/state/ws_mode"
STATE_COUNT="$HOME/.config/waybar/state/ws_count"

# ===== Leer modo y cantidad de workspaces =====
mode="grid"
[ -f "$STATE_MODE" ] && mode=$(cat "$STATE_MODE")

ws_num=4
[ -f "$STATE_COUNT" ] && ws_num=$(cat "$STATE_COUNT")

# ===== Workspace activo =====
CUR=$(hyprctl activeworkspace -j | jq -r '.id // empty')
[ -z "$CUR" ] && exit 0

DIR="$1"  # left, right, up, down

# ===== Función para mover en grid o vertical =====
move_workspace() {
    local cur=$1
    local dir=$2
    local total=$3

    if [ "$mode" = "linear" ]; then
        # Modo vertical: fila horizontal, circular
        case "$dir" in
            left)  next=$(( (cur - 2 + total) % total + 1 )) ;;
            right) next=$(( cur % total + 1 )) ;;
            up)    next=$(( (cur - 2 + total) % total + 1 )) ;;
            down)  next=$(( cur % total + 1 )) ;;
        esac
    else
        # Modo grid: dos filas lo más cuadradas posible
        rows=$(( (total + 1) / 2 )) # primera fila = ceil(total/2)
        first_row_end=$rows
        second_row_start=$((rows + 1))

        case "$dir" in
            left)
                if [ $cur -le $rows ]; then
                    # fila 1
                    next=$(( cur - 1 ))
                    [ $next -lt 1 ] && next=$rows
                else
                    # fila 2
                    next=$(( cur - 1 ))
                    [ $next -lt $second_row_start ] && next=$total
                fi
                ;;
            right)
                if [ $cur -le $rows ]; then
                    next=$(( cur + 1 ))
                    [ $next -gt $first_row_end ] && next=1
                else
                    next=$(( cur + 1 ))
                    [ $next -gt $total ] && next=$second_row_start
                fi
                ;;
            up)
                if [ $cur -le $rows ]; then
                    next=$cur
                else
                    next=$(( cur - rows ))
                fi
                ;;
            down)
                if [ $cur -le $rows ]; then
                    next=$(( cur + rows ))
                    [ $next -gt $total ] && next=$cur
                else
                    next=$cur
                fi
                ;;
        esac
    fi

    hyprctl dispatch workspace $next
}

move_workspace $CUR $DIR $ws_num
