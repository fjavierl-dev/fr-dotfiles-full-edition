#!/usr/bin/env bash

CONFIG="$HOME/.config/waybar/config"

# 1. Obtener margen lateral actual
current=$(grep '"margin-left":' "$CONFIG" | grep -o '[0-9]\+' | head -n1)
[ -z "$current" ] && current=0

# 2. Menú de selección con la lista completa hasta 300
choice=$(printf "0\n10\n20\n30\n40\n50\n60\n70\n80\n90\n100\n110\n120\n130\n140\n150\n160\n170\n180\n190\n200\n210\n220\n230\n240\n250\n260\n270\n280\n290\n300" | \
    rofi -dmenu -p "Padding Lateral (Actual: ${current}px)")

[ -z "$choice" ] && exit 0

if [[ "$choice" =~ ^[0-9]+$ ]]; then

    # 3. Limpiar márgenes antiguos
    sed -i '/"margin-left":/d' "$CONFIG"
    sed -i '/"margin-right":/d' "$CONFIG"

    # 4. Insertar los nuevos márgenes
    if grep -q '"position": *"top"' "$CONFIG"; then
        sed -i '/"position": *"top"/a \    "margin-left": '$choice',\n    "margin-right": '$choice',' "$CONFIG"
    elif grep -q '"position": *"bottom"' "$CONFIG"; then
        sed -i '/"position": *"bottom"/a \    "margin-left": '$choice',\n    "margin-right": '$choice',' "$CONFIG"
    else
        sed -i '/"layer": *"top"/a \    "margin-left": '$choice',\n    "margin-right": '$choice',' "$CONFIG"
    fi

    # 5. Reiniciar Waybar
    killall waybar
    sleep 0.1
    waybar & > /dev/null 2>&1
    
    notify-send "Waybar" "Padding lateral: ${choice}px" -i sp_check
fi
