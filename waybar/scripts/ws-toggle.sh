#!/usr/bin/env bash

STATE="$HOME/.config/waybar/state/ws_mode"

mkdir -p "$(dirname "$STATE")"

[ ! -f "$STATE" ] && echo grid > "$STATE"

if [ "$(cat "$STATE")" = "grid" ]; then
  echo linear > "$STATE"
else
  echo grid > "$STATE"
fi
