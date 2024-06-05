#!/bin/bash

# setting pacman config
# sudo wget -O /etc/pacman.conf 

# Setup Blackarch repository for pacmani
echo " ---- Setting up BlackArch ---- "
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh

sudo wget -O /etc/pacman.conf  https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/pacman/pacman.conf
sudo pacman -Syu # remember to add sudo

echo " ---- Installing Packages ---"
# installing hardware specific packages for GPU stuff
sudo pacman -S intel-compute-runtime --noconfirm

# install software I will always need
# remember to add sudo
sudo pacman -S nmap firefox neovim base-devel git intel-ucode gnu-netcat metasploit exploitdb ffuf burpsuite code thunar obsidian zsh net-tools ttf-font-awesome fastfetch rofi brightnessctl pamixer hashcat seclists waybar openvpn hydra discord vivaldi bluez bluez-utils blueberry --noconfirm

# enable bluetooth
sudo systemctl enable bluetooth.service

echo " ---- Installing yay ---- "
# Download/Install yay for AUR
mkdir -p Software
cd Software
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~

yay -S ticktick notion-app xmind

# install Joplin
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

echo " ---- Setting up OS Config ---- "
# make sure config directories exist
mkdir -p ~/.config/hypr
mkdir -p ~/.config/kitty
mkdir -p ~/.config/waybar

# Download my backup config files
wget -O ~/.config/hypr/hyprland.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/hypr/hyprland.conf
wget -O ~/.config/hypr/hyprlock.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/hypr/hyprlock.conf
wget -O ~/.config/hypr/hyprpaper.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/hypr/hyprpaper.conf
wget -O ~/.config/kitty/kitty.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/kitty/kitty.conf
wget -O ~/.config/waybar/config https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/waybar/config
wget -O ~/.config/waybar/style.css https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/waybar/style.css

echo " ---- Setting up Wordlists ---- "
# setup and download wordlists
sudo mkdir -p /usr/share/wordlists
sudo mkdir -p /usr/share/wordlists/dirb
sudo mkdir -p /usr/share/wordlists/dirbuster
sudo mv /usr/share/seclists /usr/share/wordlists
sudo wget -O /usr/share/wordlists/rockyou.txt.gz https://github.com/praetorian-inc/Hob0Rules/raw/master/wordlists/rockyou.txt.gz
sudo gunzip /usr/share/wordlists/rockyou.txt.gz
sudo wget -O /usr/share/wordlists/dirb/common.txt https://raw.githubusercontent.com/v0re/dirb/master/wordlists/common.txt
sudo wget -O /usr/share/wordlists/dirb/big.txt https://raw.githubusercontent.com/v0re/dirb/master/wordlists/big.txt
sudo wget -O /usr/share/wordlists/dirbuster/directory-list-2.3-big.txt https://raw.githubusercontent.com/daviddias/node-dirbuster/master/lists/directory-list-2.3-big.txt
cd /usr/share/wordlists
sudo git clone https://github.com/insidetrust/statistically-likely-usernames.git
cd ~

echo " ---- Setting up SSH Key for Github ---- "
# Setup SSH key for GitHub
ssh-keygen -t ed25519 -C "m0kai@github.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
# echo "Copy+Paste the following Public Key to GitHub:"
# cat ~/.ssh/id_ed25519.pub

echo " ---- Installing and configuring oh-my-zsh ---- "
# Install oh-my-szh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Download theme and my configured .zshrc file
wget -O ~/.oh-my-zsh/themes/heapbytes.zsh-theme https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/zsh/heapbytes.zsh-theme
wget -O ~/.zshrc https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/zsh/.zshrc

echo "Copy+Paste the following Public Key to GitHub:"
cat ~/.ssh/id_ed25519.pub
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

echo " ---- Pulling Down Repos ---"
mkdir -p ~/Repos
mkdir -p ~/Documents
cd Repos
git clone git@github.com:m0kai/post-install-script.git
git clone git@github.com:m0kai/arch-dotfiles.git
#cd ~/Documents
git clone git@github.com:m0kai/Grimoire.git

# Setup Git with my author information
git config --global user.email "m0kai@proton.me"
git config --global user.name "m0kai"

# Create final few directories
cd ~
mkdir -p ~/VPNs
