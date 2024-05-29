#!/bin/bash
sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

wget -O ~/.oh-my-zsh/themes/heapbytes.zsh-theme https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/zsh/heapbytes.zsh-theme
wget -O ~/.zshrc https://raw.githubusercontent.com/m0kai/arch-dotfiles/main/zsh/.zshrc
