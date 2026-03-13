#!/usr/bin/env bash
# Script para cambiar estilo de Fastfetch sin reemplazar el logo

CONFIG="$HOME/.config/fastfetch/config.jsonc"
STYLE_FILE="$HOME/.config/hypr/styles/fastfetch/style01.jsonc"

# Hacer backup del config actual
cp "$CONFIG" "$CONFIG.bak"

# Extraer solo los módulos, display y colores del estilo seleccionado
tmp=$(mktemp)
jq '{modules, display, colors}' "$STYLE_FILE" > "$tmp"

# Mezclar con el logo actual
jq --slurpfile new "$tmp" '
.logo = .logo // {} |
.modules = ($new[0].modules // .modules) |
.display = ($new[0].display // .display) |
.colors = ($new[0].colors // .colors)
' "$CONFIG" > "$tmp" && mv "$tmp" "$CONFIG"

notify-send "Fastfetch" "Estilo 'style01' aplicado"
