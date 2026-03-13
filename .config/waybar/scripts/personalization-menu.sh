#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

choice=$(printf "Waybar\nWaybar Layout\nKitty Theme\nKitty Opacity\nKitty Blur ON OFF\n[BREAK]Kitty Blur Level\nBorder Size\nWindow Corners\nActive Border Color\nInactive Border Color\nInner Gaps\nOuter Gap\nHyprland Active Opacity\nHyprland Inactive Opacity\nOther Options (scrollable)...\nChange Fastfetch Logo\nChange Fastfetch Style\nBack" | rofi -dmenu -p "Personalization")

case "$choice" in
  Waybar)
    "$SCRIPT_DIR/waybar-menu.sh"
    ;;
  "Waybar Layout")
    "$SCRIPT_DIR/waybar-layout.sh"
    ;;
  "Kitty Theme")
    "$SCRIPT_DIR/kitty-theme.sh"
    ;;
  "Kitty Opacity")
    "$SCRIPT_DIR/kitty-transparency.sh"
    ;;
  "Kitty Blur ON OFF")
    "$SCRIPT_DIR/kitty-blur.sh"
    ;; 
  "Kitty Blur Level")
    "$SCRIPT_DIR/kitty-blur-level.sh"
    ;;
  "Border Size")
    ~/.config/hypr/scripts/border-size-menu.sh
    ;;
  "Active Border Color")
    ~/.config/hypr/scripts/active-border-color-menu.sh
    ;;
  "Window Corners")
    ~/.config/hypr/scripts/window-corners.sh
    ;;
  "Inactive Border Color")
    ~/.config/hypr/scripts/inactive-border-color-menu.sh
    ;;
  "Inner Gaps")
    ~/.config/hypr/scripts/gaps-in-menu.sh
    ;;
  "Outer Gaps")
    ~/.config/hypr/scripts/gaps-out-menu.sh
    ;;
  "Hyprland Active Opacity")
    "$SCRIPT_DIR/active-opacity.sh"
    ;;
  "Hyprland Inactive Opacity")
    "$SCRIPT_DIR/inactive-opacity.sh"
    ;;
   "Change Fastfetch Logo")
    ~/.config/hypr/scripts/change-fastfetch-logo.sh
    ;;
   "Change Fastfetch Style")
    ~/.config/hypr/scripts/change-fastfetch-style.sh
    ;;
  Back)
    "$SCRIPT_DIR/settings-menu.sh"
    ;;
  *)
    exit 0
    ;;
esac
