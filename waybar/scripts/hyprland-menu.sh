#!/bin/bash
SCRIPT_DIR="$(dirname "$0")"

choice=$(printf "Border Size\nWindow Corners\nToggle Animations\nActive Border Color\nInactive Border Color\nInner Gaps\nOuter Gaps\nActive Opacity\nInactive Opacity\nBack" | rofi -dmenu -p "Personalization")

case "$choice" in
  "Border Size")
    ~/.config/hypr/scripts/border-size-menu.sh
    ;;
  "Active Border Color")
    ~/.config/hypr/scripts/active-border-color-menu.sh
    ;;
  "Window Corners")
    ~/.config/hypr/scripts/window-corners.sh
    ;;
  "Toggle Animations")
    ~/.config/hypr/scripts/toggle-animations.sh
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
  "Active Opacity")
    "$SCRIPT_DIR/active-opacity.sh"
    ;;
  "Inactive Opacity")
    "$SCRIPT_DIR/inactive-opacity.sh"
    ;;
  Back)
    "$SCRIPT_DIR/personalization-menu.sh"
    ;;
  *)
    exit 0
    ;;
esac
