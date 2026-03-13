#!/usr/bin/env bash

CONFIG="$HOME/.config/waybar/config"
HYPR_WS="$HOME/.config/hypr/workspaces.conf"
HYPR_BINDS="$HOME/.config/hypr/workspace-binds.conf"

# Leer cantidad de workspaces deseada
STATE_COUNT="$HOME/.config/waybar/state/ws_count"
ws_num=4
[ -f "$STATE_COUNT" ] && ws_num=$(cat "$STATE_COUNT")

# Detectar si el módulo ws-grid está activo
if grep -q '"modules-left": \["custom/ws-grid"' "$CONFIG"; then
    # ===== DESACTIVAR =====

    # Quitar módulo visual
    sed -i 's/"modules-left": \["custom\/ws-grid",/"modules-left": [/' "$CONFIG"
    sed -i 's/"modules-left": \["custom\/ws-grid"\]/"modules-left": []/' "$CONFIG"

    # Vaciar workspaces reales
    > "$HYPR_WS"

    # Dejar solo bind del workspace 1
    cat > "$HYPR_BINDS" <<EOF
bind = SUPER, 1, workspace, 1
EOF

    # Volver al workspace 1
    hyprctl dispatch workspace 1

    # Recargar Hyprland
    hyprctl reload

    notify-send "Workspaces disabled (Single mode)"

else
    # ===== ACTIVAR =====

    # Agregar módulo visual
    sed -i 's/"modules-left": \[/"modules-left": ["custom\/ws-grid", /' "$CONFIG"

    # Restaurar workspaces reales según ws_num
    > "$HYPR_WS"
    for i in $(seq 1 "$ws_num"); do
        echo "workspace = $i, persistent:true" >> "$HYPR_WS"
    done

    # Restaurar binds de SUPER+N según ws_num
    > "$HYPR_BINDS"
    for i in $(seq 1 "$ws_num"); do
        echo "bind = SUPER, $i, workspace, $i" >> "$HYPR_BINDS"
    done

    # Recargar Hyprland
    hyprctl reload

    notify-send "Workspaces enabled (Multi mode, $ws_num workspaces)"
fi

# Recargar Waybar
pkill -USR2 waybar
