#!/bin/bash

# Variable definitions
RED='\033[0;31m'
NOCOLOR='\033[0m'
GREEN='\033[0;32m'

# Array Definitions
PACMANPACKAGES=("burpsuite" "nmap" "neovim" "base-devel" "amd-ucode" "gnu-netcat" "thunar" "obsidian" "zsh" "net-tools" "ttf-font-awesome" "ttf-bigblueterminal-nerd" "fastfetch" "brightnessctl" "pamixer" "discord" "bluez" "bluez-utils" "blueberry" "mousepad" "signal-desktop" "gnome-themes-extra" "steam" "cuda" "rofi")
YAYPACKAGES=("hyprshot" "1password" "hyprland-qtutils" "opera")

# function definitions
validate_operation() {
  local exit_code=$1
  local message=$2

  if [ $exit_code == 0 ]; then
    printf "${message} ${GREEN}successful ${NOCOLOR}\n"
  else
    printf "${message} ${RED}failed ${NOCOLOR}\n"
  fi
}

# nvidia_driver_install() {
# 	echo 'QT_QPA_PLATFORMTHEME="wayland;xcb"' | sudo tee -a /etc/environment >/dev/null
# 	echo 'GBM_BACKEND=nvidia-drm' | sudo tee -a /etc/environment >/dev/null
# 	echo '__GLX_VENDOR_LIBRARY_NAME=nvidia' | sudo tee -a /etc/environment >/dev/null
# 	echo 'ENABLE_VKBASALT=1' | sudo tee -a /etc/environment >/dev/null
# 	echo 'LIBVA_DRIVER_NAME=nvidia' | sudo tee -a /etc/environment >/dev/null
# 	echo 'WLR_NO_HARDWARE_CURSORS=1' | sudo tee -a /etc/environment >/dev/null
# 	echo 'Put the following into MODULES=() in  /etc/mkinitcpio.conf'
# 	echo 'nvidia nvidia_modeset nvidia_uvm nvidia_drm'
# 	read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# 	sudo mkinitcpio -P
# 	echo 'Put the following into /boot/loader/entries/xxx.conf'
# 	echo "nvidia-drm.modeset=1"
# 	exit 0
# }

# keeping as an example for now
#printf "standard ${RED}red ${NOCOLOR}no color ${GREEN}green\n"
# Add to end of command to suppress output: >/dev/null 2>&1

# Actual start of script
# printf "Setup nvidia proprietary driver config? (y/n) \n"
# read answer

# if [ $answer == "y" ]; then
# 	nvidia_driver_install
# fi
main_menu() {
  echo " ---------- Welcome Killakxmi ---------- "
  echo "1) Setup Github SSH Key"
  echo "2) Install yay"
  echo "3) Install hashcat"
  echo "4) Install AUR software"
  echo "5) Setup BlackArch"
  echo "6) Install Pacman Packages"
  echo "7) Setup Config Dot Files"
  echo "8) Download wordlists"
  echo "9) Install and Configure oh-my-zsh"
  echo "10) Setup personal repositories"
  echo "11) Setup LazyVim"
  echo "12) Do all"
  echo "13) Custom Order"

  read -p "Please enter your choice:" user_choice

  export CHOICE=$user_choice
}
setup_ssh() {
  printf " ---- Setting up SSH Key for Github ---- \n"
  # Setup SSH key for GitHub
  ssh-keygen -t ed25519 -C "m0kai@github.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  echo "Copy+Paste the following Public Key to GitHub:"
  cat ~/.ssh/id_ed25519.pub
  read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

  sudo pacman -S git --noconfirm
}

install_yay() {
  printf " ---- Installing yay --- \n"
  mkdir -p Software
  cd Software
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  cd ~
}

install_hashcat() {
  printf " ---- Installing Hashcat ---- \n"
  cd Software
  git clone https://github.com/hashcat/hashcat.git
  cd hashcat
  make
  sudo make install
  cd ~
}

install_aur_software() {
  printf " ---- Installing AUR Software ---- \n"
  for package in ${YAYPACKAGES[@]}; do
    yay -S $package
  done
}

setup_blackarch() {
  printf " ---- Setting up BlackArch ---- \n"
  curl -O https://blackarch.org/strap.sh >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "Black Arch strap.sh Download:"

  chmod +x strap.sh
  sudo ./strap.sh >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "Black Arch install:"

  sudo wget -O /etc/pacman.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/pacman/pacman.conf >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "pacman config download:"

  printf " ---- Updating Pacman ---- \n"
  sudo pacman -Syu --noconfirm >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "Pacman Update:"
}

install_pacman_packages() {
  printf " ---- Installing $(GREEN)Pacman $(NOCOLOR) Packages ---- \n"
  for package in ${PACMANPACKAGES[@]}; do
    sudo pacman -S $package --noconfirm >/dev/null 2>&1
    CODE=$?
    validate_operation $CODE "${package} install:"
  done
}

setup_dotfiles() {
  printf " ---- Setting up dotfiles ---- \n"
  # make sure config directories exist
  mkdir -p ~/.config/hypr
  mkdir -p ~/.config/kitty
  mkdir -p ~/.config/waybar

  wget -O ~/.config/hypr/hyprland.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/hypr/hyprland.conf >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "hyprland config:"

  wget -O ~/.config/hypr/hyprlock.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/hypr/hyprlock.conf >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "hyprlock config:"

  wget -O ~/.config/hypr/hyprpaper.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/hypr/hyprpaper.conf >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "hyprpaper config:"

  wget -O ~/.config/kitty/kitty.conf https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/kitty/kitty.conf >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "kitty config:"

  wget -O ~/.config/waybar/config https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/waybar/config >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "waybar config:"

  wget -O ~/.config/waybar/style.css https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/waybar/style.css >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "waybar CSS:"
}

download_wordlists() {
  printf " ---- Downloading Wordlists ---- "
  sudo mkdir -p /usr/share/wordlists
  sudo mkdir -p /usr/share/wordlists/dirb
  sudo mkdir -p /usr/share/wordlists/dirbuster

  sudo wget -O /usr/share/wordlists/rockyou.txt.gz https://github.com/praetorian-inc/Hob0Rules/raw/master/wordlists/rockyou.txt.gz >/dev/null 2>&1
  sudo gunzip /usr/share/wordlists/rockyou.txt.gz >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "rockyou install:"

  sudo wget -O /usr/share/wordlists/dirb/common.txt https://raw.githubusercontent.com/v0re/dirb/master/wordlists/common.txt >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "dirb common install:"

  sudo wget -O /usr/share/wordlists/dirb/big.txt https://raw.githubusercontent.com/v0re/dirb/master/wordlists/big.txt >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "dirb big install"

  sudo wget -O /usr/share/wordlists/dirbuster/directory-list-2.3-big.txt https://raw.githubusercontent.com/daviddias/node-dirbuster/master/lists/directory-list-2.3-big.txt >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "dirbuster install:"

  cd /usr/share/wordlists
  sudo git clone https://github.com/insidetrust/statistically-likely-usernames.git >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "statistically likely usernames install:"
  cd ~
}
install_config_oh_my_zsh() {
  printf " ---- Installing and configuring oh-my-zsh ---- \n"
  # Install oh-my-szh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Download theme and my configured .zshrc file
  wget -O ~/.oh-my-zsh/themes/heapbytes.zsh-theme https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/zsh/heapbytes.zsh-theme >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "zsh theme install:"

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "zsh syntax highlighting install:"

  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "zsh auto suggestions install:"

  wget -O ~/.zshrc https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/zsh/.zshrc >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "zsh config install"
}

setup_personal_repos() {
  printf " ---- Pulling Down Repos ---- \n"
  mkdir -p ~/Repos
  mkdir -p ~/Documents
  cd Repos

  git clone git@github.com:m0kai/post-install-script.git >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "post-instal repo download:"

  git clone git@github.com:m0kai/arch-dotfiles.git >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "dotfile repo download:"

  cd ~/Documents
  git clone git@github.com:m0kai/Grimoire.git >/dev/null 2>&1
  CODE=$?
  validate_operation $CODE "Grimoire Download:"

  # Setup Git with my author information
  git config --global user.email "m0kai@proton.me"
  git config --global user.name "m0kai"
}
# Create final few directories
# cd ~
# mkdir -p ~/VPNs

# Setup LazyVim
setup_lazyvim() {
  pirntf " ---- Setting up LazyVim  ---- \n"
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
  rm -rf ~/.local/state/nvim
  rm -rf ~/.cache/nvim
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
  printf "Open nvim to finish setup!\n"
}

# Execution starts here:quit_code
while true; do

  if [ "$1" == 'all' ]; then
    export CHOICE=12
  else
    main_menu
  fi

  if [ $CHOICE == 12 ]; then
    setup_ssh
    install_yay
    install_hashcat
    install_aur_software
    setup_blackarch
    install_pacman_packages
    setup_dotfiles
    download_wordlists
    install_config_oh_my_zsh
    setup_personal_repos
    setup_lazyvim
  fi

  read -p "Quit? (y/n)" quit_code

  if [ $quit_code == 'y' ]; then
    break
  fi
done

#echo $choice
printf "Goodbye!\n"
