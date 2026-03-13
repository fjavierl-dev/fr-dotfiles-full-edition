
#!/usr/bin/env bash
SCRIPT_DIR="$(dirname "$0")"



CONFIG="$HOME/.config/waybar/config"
[ -f "$HOME/.config/waybar/config.jsonc" ] && \
  CONFIG="$HOME/.config/waybar/config.jsonc"

choice=$(printf "100\n90\n80\n70\n60\n50\n40\n30\n20\n10\nBack" | \
  rofi -dmenu -p "Waybar size (%)")

[ -z "$choice" ] && exit 0


if [ "$choice" = "Back" ]; then
  "$SCRIPT_DIR/waybar-menu.sh"
  exit 0
fi


# Convertir porcentaje a valor real
# 100% = 60
# 50%  = 30
# etc

value=$(( choice * 60 / 100 ))

sed -i '0,/"height":/s/"height": *[0-9]\+/"height": '"$value"'/' "$CONFIG"


pkill -USR2 waybar
