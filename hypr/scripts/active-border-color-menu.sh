#!/usr/bin/env bash

CSS_FILE="$HOME/.config/waybar/style.css"

# Función para validar color CSS (hex #RRGGBB o nombres CSS comunes)
is_valid_color() {
    local c="$1"
    # Hex #RRGGBB
    if [[ "$c" =~ ^#([0-9a-fA-F]{6})$ ]]; then
        return 0
    fi
    # Nombres CSS comunes
    case "$c" in
        transparent|red|green|blue|white|yellow|purple) return 0 ;;
        *) return 1 ;;
    esac
}

#legir el color de borde / Hyprland
color_choice=$(printf "Transparent\nRed\nGreen\nBlue\nWhite\nYellow\nPurple\nCustom (single color)\nCustom (convinated 2 colors)\nBack" | \
  rofi -dmenu -p "Active Border Color")
[ -z "$color_choice" ] && exit 0

case "$color_choice" in
  Transparent)
    color_css="transparent"
    color_rgba="rgba(00000000)"
    ;;
  Red)
    color_css="red"
    color_rgba="rgba(ff0000ff)"
    ;;
  Green)
    color_css="green"
    color_rgba="rgba(00ff00ff)"
    ;;
  Blue)
    color_css="blue"
    color_rgba="rgba(0000ffff)"
    ;;
  White)
    color_css="white"
    color_rgba="rgba(ffffffff)"
    ;;
  Yellow)
    color_css="yellow"
    color_rgba="rgba(ffff00ff)"
    ;;
  Purple)
    color_css="purple"
    color_rgba="rgba(aa00ffff)"
    ;;
  "Custom (single color)")
    single_color=$(rofi -dmenu -p $'Enter custom color:\n(Example: #3B4A61)')
    [ -z "$single_color" ] && exit 0

    # Validar formato HEX
    if [[ ! "$single_color" =~ ^#([0-9a-fA-F]{6})$ ]]; then
        rofi -e "Invalid format. Use #RRGGBB"
        exit 0
    fi

    color_css="$single_color"

    # Convertir a formato Hyprland rgba(RRGGBBff)
    hex="${single_color#\#}"
    color_rgba="rgba(${hex}ff)"
    ;;
  "Custom (convinated 2 colors)")
    # Pedir color/gradiente para Hyprland
    custom_color=$(rofi -dmenu -p $'Enter custom color:\n(Example: rgba(ed254dee) rgba(fbff11ee))')
    [ -z "$custom_color" ] && exit 0
    color_rgba="$custom_color"

    # Extraer primer color sólido para Waybar
    waybar_color=$(echo "$custom_color" | grep -o 'rgba([^)]*)' | head -n1)
    # Convertir #RRGGBBAA a #RRGGBB si está en hex alfa
    waybar_color=$(echo "$waybar_color" | sed -E 's/rgba\(([0-9a-fA-F]{6})[0-9a-fA-F]{2}\)/#\1/')
    [ -z "$waybar_color" ] && waybar_color="$custom_color"

    color_css="$waybar_color"

    # Validar solo si es Custom
    if ! is_valid_color "$color_css"; then
        echo "Color inválido para Waybar: $color_css. Se usará fallback #303030."
        color_css="#303030"
    fi
    ;;
  Back)
    ~/.config/waybar/scripts/hyprland-menu.sh
    exit 0
    ;;
esac

#ambiar el borde activo de la ventana en Hyprland
hyprctl keyword general:col.active_border "$color_rgba"

#legir estilo de Waybar
style_choice=$(printf "Border Style 1\nNo Border" | rofi -dmenu -p "Waybar Theme Style")
[ -z "$style_choice" ] && exit 0

case "$style_choice" in
  "Border Style 1")
    sed -i "/^#waybar[[:space:]]*{/,/}/ s/border:.*;/border: 2px solid $color_css;/g" "$CSS_FILE"
    ;;
  "No Border")
    sed -i "/^#waybar[[:space:]]*{/,/}/ s/border:.*;/border: none;/g" "$CSS_FILE"
    ;;
esac

#einiciar Waybar
pkill waybar
waybar &
