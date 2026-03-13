#!/bin/bash

set -e

# ==============================
#        FR DOTFILES
# ==============================

# Color rojo elegante
echo -e "\e[38;2;170;0;0m"

cat << "EOF"

███████╗██████╗
██╔════╝██╔══██╗
█████╗  ██████╔╝
██╔══╝  ██╔══██╗
██║     ██║  ██║
╚═╝     ╚═╝  ╚═╝

        ── Fjavierl Dotfiles ──

EOF

# Reset color
echo -e "\e[0m"

echo "==> Installing FR Dotfiles..."
echo

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# ==============================
# 1. Remove conflicting packages
# ==============================
CONFLICTS=(fastfetch-git wlogout hyprpaper)
for pkg in "${CONFLICTS[@]}"; do
    if pacman -Qs "$pkg" &>/dev/null || yay -Qs "$pkg" &>/dev/null; then
        echo "==> Removing conflicting package $pkg..."
        sudo pacman -Rns --noconfirm "$pkg" || yay -R --noconfirm "$pkg" || true
    fi
done

# ==============================
# 2. Install Official Packages
# ==============================
OFFICIAL_PACKAGES=(
  hyprland waybar rofi-wayland jq git pipewire pipewire-pulse wireplumber
  pavucontrol networkmanager network-manager-applet wpa_supplicant
  grim slurp bluez bluez-utils blueman gsimplecal kitty fastfetch
  cmatrix gnome-keyring zenity cava wl-clipboard libnotify
)

echo "==> Installing required official packages..."
for pkg in "${OFFICIAL_PACKAGES[@]}"; do
    sudo pacman -S --needed --noconfirm "$pkg" || echo "⚠️ Could not install $pkg, skipping..."
done
echo "==> Official dependencies installed."
echo

# ==============================
# 3. Install yay if missing
# ==============================
if ! command -v yay &>/dev/null; then
    echo "==> Installing yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
fi

# ==============================
# 4. Install AUR Packages
# ==============================
AUR_PACKAGES=(wlogout mpvpaper fastfetch-git swww faugus-launcher visual-studio-code-bin spotify)
echo "==> Installing AUR packages..."
for pkg in "${AUR_PACKAGES[@]}"; do
    yay -S --needed --noconfirm "$pkg" || echo "⚠️ Could not install AUR package $pkg, skipping..."
done
echo "==> AUR packages installed."
echo

# ==============================
# 4.1 Extra Packages
# ==============================
echo "==> Installing Flatpak..."
sudo pacman -S --needed --noconfirm flatpak

echo "==> Adding Flathub repository..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "==> Installing Pamac AUR..."
sudo pacman -S --needed --noconfirm pamac-aur

echo

# ==============================
# 5. Backup Existing Configs
# ==============================
mkdir -p "$HOME/.config"

# ==============================
# 5. Backup Existing Configs
# ==============================
mkdir -p "$HOME/.config"

for cfg in waybar hypr gsimplecal; do
    if [ -d "$HOME/.config/$cfg" ]; then
        echo "==> Backing up existing $cfg config..."
        mv "$HOME/.config/$cfg" "$HOME/.config/${cfg}.backup.$(date +%Y%m%d-%H%M%S)"
    fi
done
echo

# ==============================
# 6. Copy Configurations
# ==============================
echo "==> Copying Waybar config..."
cp -r "$REPO_DIR/waybar" "$HOME/.config/"

echo "==> Copying Hypr config..."
cp -r "$REPO_DIR/hypr" "$HOME/.config/"

echo "==> Copying gsimplecal config..."
cp -r "$REPO_DIR/gsimplecal" "$HOME/.config/"
echo

# ==============================
# 7. Enable System Services
# ==============================
SYSTEM_SERVICES=(NetworkManager bluetooth)
echo "==> Enabling system services..."
for svc in "${SYSTEM_SERVICES[@]}"; do
    if systemctl list-unit-files | grep -q "^${svc}.service"; then
        sudo systemctl enable "$svc"
        echo "==> $svc enabled"
    else
        echo "⚠️ Service $svc not found, skipping..."
    fi
done
echo

# ==============================
# 8. Enable User Services (pipewire, wireplumber, swww)
# ==============================
USER_SERVICES=(pipewire pipewire-pulse wireplumber swww)
echo "==> Enabling user services..."
for svc in "${USER_SERVICES[@]}"; do
    if systemctl --user list-unit-files | grep -q "^${svc}.service"; then
        systemctl --user enable --now "$svc"
        echo "==> $svc enabled and started"
    else
        echo "⚠️ User service $svc not found, skipping..."
    fi
done
echo

# ==============================
# 9. Install Themes
# ==============================

# Kitty
echo "==> Installing Kitty themes..."
mkdir -p "$HOME/.config/kitty"
if [ ! -d "$HOME/.config/kitty/kitty-themes" ]; then
    git clone https://github.com/dexpota/kitty-themes "$HOME/.config/kitty/kitty-themes"
    echo "==> Kitty themes installed."
else
    echo "==> Kitty themes already exist. Skipping."
fi

# Rofi
echo "==> Installing Rofi themes..."
if [ ! -d "$HOME/.config/rofi-themes-collection" ]; then
    git clone https://github.com/lr-tech/rofi-themes-collection.git "$HOME/.config/rofi-themes-collection"
    echo "==> Rofi themes installed."
else
    echo "==> Rofi themes already exist. Skipping."
fi

echo
echo "✅ FR Dotfiles installation complete!"
echo "Reboot or start Hyprland to apply changes."
