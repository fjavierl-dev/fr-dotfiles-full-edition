#!/usr/bin/env bash

STATE="$HOME/.config/waybar/state/ws_count"
mkdir -p "$(dirname "$STATE")"

choice=$(printf "1\n2\n3\n4\n5\n6\n7\n8\n9\nBack" | rofi -dmenu -p "Number of Workspaces")

case "$choice" in
    [1-9])
        echo "$choice" > "$STATE"
        notify-send "Workspaces count set to $choice"
        ;;
    "Back"|"" )
        exit 0
        ;;
esac
