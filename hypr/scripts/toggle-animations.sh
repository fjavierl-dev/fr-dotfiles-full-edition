#!/bin/bash

choice=$(printf "Enable Animations\nDisable Animations\nBack" | \
    rofi -dmenu -p "Window Effects")

case "$choice" in
    "Enable Animations")
        hyprctl keyword animations:enabled 1
        exit 0
        ;;
    "Disable Animations")
        hyprctl keyword animations:enabled 0
        exit 0
        ;;
    "Back")
        "$HOME/.config/waybar/scripts/hyprland-menu.sh"
        exit 0
        ;;
esac
