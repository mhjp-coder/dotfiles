#!/bin/bash

# linux
##########################################
# Configure New Arch Linux
##########################################
set -e

# Setup pacman with color and parallel downloads
sudo sed -i 's/#Color/Color/' /etc/pacman.conf
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf

# Add user to sudoers NOPASSWD
sudo echo "$(whoami) ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/00_$(whoami)

# Install base-devel, chezmoi, git, rust
sudo pacman -S --noconfirm --needed base-devel chezmoi git rust zsh

sudo chsh -s $(which zsh) $(whoami)
#
# Install AUR helper paru
if ! command -v paru 2>&1 >/dev/null
then
    echo "########### Installing paru AUR helper ###########"
    rm -rf paru
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg --syncdeps --install --noconfirm --needed
    cd ..
    rm -rf paru
fi

# Update mirrors
paru -S --noconfirm --needed rate-mirrors-bin
rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist

# Get the dotfiles
chezmoi init --apply mhjp-coder
