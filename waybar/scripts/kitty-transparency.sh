#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
CONFIG="$HOME/.config/kitty/kitty.conf"

while true; do
    choice=$(printf "100%%\n90%%\n80%%\n70%%\n60%%\n50%%\n40%%\n30%%\n20%%\n10%%\n0%%\nBack" | \
        rofi -dmenu -p "Kitty Opacity")

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

        "Back")
            "$SCRIPT_DIR/kitty-menu.sh"
            exit 0
            ;;
        "")
            exit 0
            ;;
    esac

    if grep -q "^background_opacity" "$CONFIG"; then
        sed -i "s/^background_opacity.*/background_opacity $opacity/" "$CONFIG"
    else
        echo "background_opacity $opacity" >> "$CONFIG"
    fi

    killall -SIGUSR1 kitty 2>/dev/null
done
