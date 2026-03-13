#!/usr/bin/env bash

current=$(hyprctl getoption general:gaps_out | awk 'NR==1 {print $2}')

choice=$(printf "0\n5\n10\n15\n20\n30\nBack" | \
  rofi -dmenu -p "Outer Gaps (actual: $current)")

[ -z "$choice" ] && exit 0

if [ "$choice" = "Back" ]; then
    ~/.config/waybar/scripts/hyprland-menu.sh
    exit 0
fi

hyprctl keyword general:gaps_out "$choice"
