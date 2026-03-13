#!/usr/bin/env bash

# Opciones
option1="󰚰  Update System"
option2="󱂫  Remove Orphan Packages"

# Menú de Rofi
choice=$(printf "$option1\n$option2" | rofi -dmenu -p "System Maintenance")

case "$choice" in
    "$option1")
        # Abre una terminal para ver el proceso de actualización
        # Cambia 'kitty' por tu terminal si usas otra (foot, alacritty, etc.)
        kitty --title "System Update" sh -c "sudo pacman -Syu; echo 'Presiona una tecla para salir...'; read"
        ;;
    "$option2")
        # Comando para Arch Linux (pacman)
        kitty --title "Cleaning Orphans" sh -c "sudo pacman -Rns \$(pacman -Qtdq); echo 'Limpieza terminada. Presiona una tecla...'; read"
        ;;
esac
