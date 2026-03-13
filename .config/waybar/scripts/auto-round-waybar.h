#!/bin/bash
# auto-round-waybar.sh
CONFIG="$HOME/.config/waybar/config"
STYLE="$HOME/.config/waybar/style.css"

# --- Leer módulos de la config ---
# Módulos izquierda
LEFT_MODULES=$(grep -Po '"modules-left":\s*\[\K[^\]]*' "$CONFIG" | tr -d '" ')
# Módulos derecha
RIGHT_MODULES=$(grep -Po '"modules-right":\s*\[\K[^\]]*' "$CONFIG" | tr -d '" ')
# Workspaces
WORKSPACES=$(grep -Po '"workspaces":\s*\[\K[^\]]*' "$CONFIG" | tr -d '" ')

# --- Detectar primer y último módulo ---
# Primer módulo de la izquierda
FIRST_MODULE=$(echo $LEFT_MODULES $WORKSPACES | awk '{print $1}')
# Último módulo de la derecha
LAST_MODULE=$(echo $RIGHT_MODULES | awk '{print $NF}')

# --- Generar CSS ---
cat > "$STYLE" <<EOF
/* Todos los módulos */
.module {
    padding: 2px 6px;
    background: #303030; /* fondo sólido, sin transparencia */
}

/* Primer módulo (extremo izquierdo) */
#$FIRST_MODULE {
    border-top-left-radius: 12px;
    border-bottom-left-radius: 12px;
}

/* Último módulo (extremo derecho) */
#$LAST_MODULE {
    border-top-right-radius: 12px;
    border-bottom-right-radius: 12px;
}
EOF

# --- Reiniciar Waybar para aplicar cambios ---
pkill waybar
waybar &
