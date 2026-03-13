#!/usr/bin/env bash

current=$(hyprctl getoption general:gaps_in | awk 'NR==1 {print $2}')

choice=$(printf "0\n2\n5\n10\n15\n20\nBack" | \
  rofi -dmenu -p "Inner Gaps (actual: $current)")

[ -z "$choice" ] && exit 0

if [ "$choice" = "Back" ]; then
    ~/.config/waybar/scripts/personalization-menu.sh
    exit 0
fi

hyprctl keyword general:gaps_in "$choice"
