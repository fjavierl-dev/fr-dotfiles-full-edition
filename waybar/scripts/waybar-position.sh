#!/bin/bash

CONFIG="$HOME/.config/waybar/config"
[ -f "$HOME/.config/waybar/config.jsonc" ] && CONFIG="$HOME/.config/waybar/config.jsonc"

choice=$(printf "Up\nDown\nLeft\nRight" | rofi -dmenu -p "Waybar position")

case "$choice" in
  Up) pos="top" ;;
  Down) pos="bottom" ;;
  Left) pos="left" ;;
  Right) pos="right" ;;
  *) exit 0 ;;
esac

sed -i '0,/"position": "[^"]*"/s//"position": "'"$pos"'"/' "$CONFIG"

killall -SIGUSR2 waybar




