#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
CONFIG="$HOME/.config/kitty/kitty.conf"

while true; do
    # Menú de niveles de blur
    choice=$(printf "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n10\nBack" | \
        rofi -dmenu -p "Kitty Blur Level")

    case "$choice" in
        0|1|2|3|4|5|6|7|8|9|10)
            blur="$choice"
            ;;
        "Back")
            "$SCRIPT_DIR/personalization-menu.sh"
            exit 0
            ;;
        "")
            exit 0
            ;;
        *)
            continue
            ;;
    esac

    # Modificar o agregar background_blur
    if grep -q "^background_blur" "$CONFIG"; then
        sed -i "s/^background_blur.*/background_blur $blur/" "$CONFIG"
    else
        echo "background_blur $blur" >> "$CONFIG"
    fi

    # Señal a Kitty para recargar configuración
    killall -SIGUSR1 kitty 2>/dev/null
done
