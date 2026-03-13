#!/usr/bin/env bash

choice=$(printf "Transparent\nRed\nGreen\nBlue\nWhite\nGray\nDark Gray\nPurple\nBack" | \
  rofi -dmenu -p "Inactive Border Color")

[ -z "$choice" ] && exit 0

case "$choice" in
  Transparent)
    hyprctl keyword general:col.inactive_border "rgba(00000000)"
    ;;
  Red)
    hyprctl keyword general:col.inactive_border "rgba(ff0000aa)"
    ;;
  Green)
    hyprctl keyword general:col.inactive_border "rgba(00ff00aa)"
    ;;
  Blue)
    hyprctl keyword general:col.inactive_border "rgba(0000ffaa)"
    ;;
  White)
    hyprctl keyword general:col.inactive_border "rgba(ffffffff)"
    ;;
  Gray)
    hyprctl keyword general:col.inactive_border "rgba(888888cc)"
    ;;
  Dark\ Gray)
    hyprctl keyword general:col.inactive_border "rgba(444444cc)"
    ;;
  Purple)
    hyprctl keyword general:col.inactive_border "rgba(aa00ffaa)"
    ;;
  Back)
    ~/.config/waybar/scripts/hyprland-menu.sh
    ;;
esac
