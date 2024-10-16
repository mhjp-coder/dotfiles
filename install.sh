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
sudo echo "$(echo $USER) ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/00_$(echo $USER)

# Install base-devel, chezmoi, git, rust
sudo pacman -S --noconfirm --needed base-devel chezmoi git rust
#
# Install AUR helper paru
if ! command -v paru 2>&1 >/dev/null
then
    echo "########### Installing paru AUR helper ###########"
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ..
    rm -rf paru
fi

# Update mirrors
paru -S --noconfirm --needed rate-mirrors-bin
rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist

# Get the dotfiles
chezmoi init --apply mhjp-coder
