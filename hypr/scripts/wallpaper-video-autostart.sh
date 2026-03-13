#!/usr/bin/env bash

STATE="$HOME/.config/hypr/current_wallpaper_video"

[ ! -f "$STATE" ] && exit 0

VIDEO=$(cat "$STATE")
[ -z "$VIDEO" ] && exit 0
[ ! -f "$VIDEO" ] && exit 0

MONITOR=$(hyprctl monitors | grep "Monitor" | awk '{print $2}' | head -n1)

# Asegurarse de que no haya instancia previa
pkill mpvpaper 2>/dev/null

mpvpaper "$MONITOR" "$VIDEO" --loop=inf --no-audio --no-osd-bar &
