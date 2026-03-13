#!/usr/bin/env bash

# Carpeta donde guardaremos el logo
LOGO_DIR="$HOME/.config/fastfetch"
LOGO_STATE="$LOGO_DIR/logo.png"

mkdir -p "$LOGO_DIR"

# Abrir picker para elegir imagen
CHOICE=$(zenity --file-selection \
  --title="Selecciona logo para Fastfetch" \
  --file-filter="Imágenes | *.png *.jpg *.jpeg *.webp")

# Si no eligió nada, salir
[ -z "$CHOICE" ] && exit 0

# Copiar imagen seleccionada al estado del logo
cp "$CHOICE" "$LOGO_STATE"

# Feedback
notify-send "Fastfetch logo cambiado a $(basename "$CHOICE")"
