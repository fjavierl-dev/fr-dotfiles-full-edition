#!/usr/bin/env bash

current=$(hyprctl getoption general:border_size | awk 'NR==1 {print $2}')

choice=$(printf "0\n1\n2\n3\n4\n5\nBack" | \
  rofi -dmenu -p "Border size (actual: $current)")

[ -z "$choice" ] && exit 0

if [ "$choice" = "Back" ]; then
    ~/.config/waybar/scripts/hyprland-menu.sh
    exit 0
fi

hyprctl keyword general:border_size "$choice"
