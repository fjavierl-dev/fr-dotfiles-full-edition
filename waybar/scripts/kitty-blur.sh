#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
HYPR="$HOME/.config/hypr/hyprland.conf"

while true; do
    choice=$(printf "Enable Blur\nDisable Blur\nBack" | \
        rofi -dmenu -p "Global Blur")

    case "$choice" in
        "Enable Blur")
            sed -i '/blur {/,/}/ s/enabled = false/enabled = true/' "$HYPR"
            hyprctl reload
            ;;
        "Disable Blur")
            sed -i '/blur {/,/}/ s/enabled = true/enabled = false/' "$HYPR"
            hyprctl reload
            ;;
        "Back")
            "$SCRIPT_DIR/kitty-menu.sh"
            exit 0
            ;;
        "")
            exit 0
            ;;
    esac
done
