#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
HYPR="$HOME/.config/hypr/hyprland.conf"

while true; do
    choice=$(printf "Enable Blur\nDisable Blur\nBack" | \
        rofi -dmenu -p "Global Blur")

    case "$choice" in
        "Enable Blur")
            sed -i 's/enabled = false/enabled = true/' "$HYPR"
            hyprctl reload
            ;;
        "Disable Blur")
            sed -i 's/enabled = true/enabled = false/' "$HYPR"
            hyprctl reload
            ;;
        "Back")
            "$SCRIPT_DIR/personalization-menu.sh"
            exit 0
            ;;
        "")
            exit 0
            ;;
    esac
done
