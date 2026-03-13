#!/bin/bash

STYLE="$HOME/.config/waybar/style.css"

while true; do
    choice=$(printf "100%%\n90%%\n80%%\n70%%\n60%%\n50%%\n40%%\n30%%\n20%%\n10%%\n0%%\nBack" | \
        rofi -dmenu -p "Waybar Opacity")

    case "$choice" in
        "100%") opacity="1.0" ;;
        "90%")  opacity="0.9" ;;
        "80%")  opacity="0.8" ;;
        "70%")  opacity="0.7" ;;
        "60%")  opacity="0.6" ;;
        "50%")  opacity="0.5" ;;
        "40%")  opacity="0.4" ;;
        "30%")  opacity="0.3" ;;
        "20%")  opacity="0.2" ;;
        "10%")  opacity="0.1" ;;
        "0%")   opacity="0.0" ;;
        "Back"|"") break ;;
    esac

    # Cambiar CSS
    sed -i "s/rgba(20, 20, 20, [0-9.]\+)/rgba(20, 20, 20, $opacity)/" "$STYLE"

    # Recargar Waybar **sin bloquear Rofi**
    (pkill -USR2 waybar) >/dev/null 2>&1
done
