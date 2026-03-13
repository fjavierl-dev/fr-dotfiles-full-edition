#!/usr/bin/env bash

MODE=$(cat "$HOME/.config/waybar/state/workspace_mode" 2>/dev/null)

if [ "$MODE" = "vertical" ]; then
  ~/.config/hypr/scripts/ws-vertical.sh
else
  ~/.config/waybar/scripts/ws-grid.sh
fi
