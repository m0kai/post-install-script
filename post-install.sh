#!/bin/bash

# Setup Blackarch repository for pacman
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
./strap.sh
pacman -Syu # remember to add sudo

# install software I will always need
# remember to add sudo
pacman -S nmap firefox neovim base-devel git intel-ucode gnu-netcat metasploit exploitdb ffuf burpsuite code thunar obsidian zsh net-tools ttf-font-awesome fastfetch rofi --noconfirm

# Download/Install yay for AUR
mkdir -p Software
cd Software
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~

yay ticktick notion-app

# make sure config directories exist
mkdir -p ~/.config/hypr
mkdir -p ~/.config/kitty
mkdir -p ~/.config/wayland

# Download my backup config files
wget -O ~/.config/hypr/hyprland.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/hypr/hyprland.conf
wget -O ~/.config/hypr/hyprlock.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/hypr/hyprlock.conf
wget -O ~/.config/hypr/hyprpaper.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/hypr/hyprpaper.conf
wget -O ~/.config/kitty/kitty.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/kitty/kitty.conf
wget -O ~/.config/waybar/config https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/waybar/config
wget -O ~/.config/waybar/style.css https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/waybar/style.css


