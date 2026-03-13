#!/usr/bin/env bash

HYPR_DIR="$HOME/.config/hypr"

WORKSPACES="$HYPR_DIR/workspaces.conf"
BINDS="$HYPR_DIR/workspace-binds.conf"
SINGLE="$HYPR_DIR/single-workspace-mode.conf"

# Detectar si estamos en modo multi
if grep -q "workspace = 2" "$WORKSPACES"; then
    # ===== CAMBIAR A SINGLE =====

    # Quitar persistencia
    > "$WORKSPACES"

    # Solo dejar bind del 1
    cat > "$BINDS" <<EOF
bind = SUPER, 1, workspace, 1
EOF

    # Forzar cualquier intento al workspace 1
    cat > "$SINGLE" <<EOF
bind = SUPER, 2, workspace, 1
bind = SUPER, 3, workspace, 1
bind = SUPER, 4, workspace, 1
EOF

    hyprctl dispatch workspace 1
    hyprctl reload

    notify-send "Single Workspace Mode Enabled"

else
    # ===== CAMBIAR A MULTI =====

    # Restaurar persistencia
    cat > "$WORKSPACES" <<EOF
workspace = 1, persistent:true
workspace = 2, persistent:true
workspace = 3, persistent:true
workspace = 4, persistent:true
EOF

    # Restaurar binds
    cat > "$BINDS" <<EOF
bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
bind = SUPER, 4, workspace, 4
EOF

    # Vaciar archivo single
    > "$SINGLE"

    hyprctl reload

    notify-send "Multi Workspace Mode Enabled"
fi
