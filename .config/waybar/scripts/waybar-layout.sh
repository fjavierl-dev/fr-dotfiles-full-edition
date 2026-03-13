#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$0")"

choice=$(printf "Default\nMinimal\nCentered Clock\nDev\nBack" | rofi -dmenu -p "Waybar Layout")

case "$choice" in
  "Default")
    cp ~/dotfiles/waybar/layouts/default.json ~/.config/hyprpanel/waybar-layout.json
    ;;
  "Minimal")
    cp ~/dotfiles/waybar/layouts/minimal.json ~/.config/hyprpanel/waybar-layout.json
    ;;
  "Centered Clock")
    cp ~/dotfiles/waybar/layouts/centered.json ~/.config/hyprpanel/waybar-layout.json
    ;;
  "Dev")
    cp ~/dotfiles/waybar/layouts/dev.json ~/.config/hyprpanel/waybar-layout.json
    ;;
  "Back")
    "$SCRIPT_DIR/personalization-menu.sh"
    exit 0
    ;;
  *)
    exit 0
    ;;
esac

~/dotfiles/waybar/generate-config.sh

"$SCRIPT_DIR/personalization-menu.sh"
