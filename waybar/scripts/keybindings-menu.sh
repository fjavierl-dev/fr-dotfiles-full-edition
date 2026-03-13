#!/bin/bash

rofi -dmenu -p "Keybindings" << 'EOF' >/dev/null 2>&1
Basic Applications

SUPER + ENTER   → Open terminal (Kitty)
SUPER + B       → Open browser (Brave)
SUPER + Q       → Close active window
SUPER + R       → Reload Hyprland config
SUPER + D       → Open application launcher (Rofi)

Focus Navigation

SUPER + ALT + ← → Focus left
SUPER + ALT + → → Focus right
SUPER + ALT + ↑ → Focus up
SUPER + ALT + ↓ → Focus down

Persistent Workspaces

SUPER + 1 → Workspace 1
SUPER + 2 → Workspace 2
SUPER + 3 → Workspace 3
SUPER + 4 → Workspace 4

Move Windows

SUPER + CTRL + ← → Move window left
SUPER + CTRL + → → Move window right
SUPER + CTRL + ↑ → Move window up
SUPER + CTRL + ↓ → Move window down

Alternative Focus

SUPER + SHIFT + ← → Focus left window
SUPER + SHIFT + → → Focus right window
SUPER + SHIFT + ↑ → Focus upper window
SUPER + SHIFT + ↓ → Focus lower window
EOF
