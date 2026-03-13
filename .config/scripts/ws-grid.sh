#!/usr/bin/env bash

STATE="$HOME/.config/waybar/state/ws_mode"

# modo por defecto
mode="grid"
[ -f "$STATE" ] && mode=$(cat "$STATE")

active=$(hyprctl activeworkspace -j | jq -r '.id // empty')
[ -z "$active" ] && exit 0

on="⬛"
off="⬜"

ws() {
  [ "$1" -eq "$active" ] && printf "%s" "$on" || printf "%s" "$off"
}

if [ "$mode" = "linear" ]; then
  text="$(ws 1)$(ws 2)$(ws 3)$(ws 4)"
else
  text="$(ws 1)$(ws 2)\n$(ws 3)$(ws 4)"
fi


echo "{\"text\":\"$text\"}"
