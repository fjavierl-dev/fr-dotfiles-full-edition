#!/bin/bash

CONFIG="$HOME/.config/cava/config"

apply_colors() {

    awk '
    BEGIN {in_color=0}
    /^\[color\]/ {print; in_color=1; next}
    /^\[/ {in_color=0}
    !in_color {print}
    ' "$CONFIG" > "$CONFIG.tmp"

    mv "$CONFIG.tmp" "$CONFIG"

    {
        echo "[color]"
        echo "gradient = 1"
        echo "gradient_count = 6"
    } >> "$CONFIG"

    case "$1" in
        neon)
cat >> "$CONFIG" <<EOF
gradient_color_1 = '#b20cff'
gradient_color_2 = '#008ff2'
gradient_color_3 = '#0af300'
gradient_color_4 = '#fbff02'
gradient_color_5 = '#ff9804'
gradient_color_6 = '#d00000'
EOF
;;
        fire)
cat >> "$CONFIG" <<EOF
gradient_color_1 = '#330000'
gradient_color_2 = '#800000'
gradient_color_3 = '#ff0000'
gradient_color_4 = '#ff6600'
gradient_color_5 = '#ffaa00'
gradient_color_6 = '#ffff00'
EOF
;;
        ocean)
cat >> "$CONFIG" <<EOF
gradient_color_1 = '#001f3f'
gradient_color_2 = '#0074D9'
gradient_color_3 = '#7FDBFF'
gradient_color_4 = '#39CCCC'
gradient_color_5 = '#3D9970'
gradient_color_6 = '#2ECC40'
EOF
;;
        mono)
cat >> "$CONFIG" <<EOF
gradient_color_1 = '#ffffff'
gradient_color_2 = '#cccccc'
gradient_color_3 = '#999999'
gradient_color_4 = '#666666'
gradient_color_5 = '#333333'
gradient_color_6 = '#000000'
EOF
;;
    esac

    pkill cava
    sleep 0.2
    cava &
}

while true; do
    choice=$(printf "Neon\nOcean\nFire\nMonochrome\nBack" | rofi -dmenu -p "Cava Colors")

    case "$choice" in
        "Neon") apply_colors neon ;;
        "Ocean") apply_colors ocean ;;
        "Fire") apply_colors fire ;;
        "Monochrome") apply_colors mono ;;
        "Back") exit 0 ;;
        "") exit 0 ;;
    esac
done
