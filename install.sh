#!/bin/bash

# linux
##########################################
# Configure New Arch Linux
##########################################
set -e

# Check if the script is being run as root
if [ "$EUID" -e 0 ]; then
    echo "Please do nut run this script as root."
    exit 1
fi

# Prompt the user to enter a username
read -p "Please Enter the GitHub username to get the dot files from: " git_hub_username

# Get the current user
who_am_i=$(whoami)

if [[ "$(uname)" == "Linux" ]]; then
    DISTRO=$(grep '^ID=' /etc/os-release | cut -d'=' -f2)
    echo "This is a Linux system running $DISTRO."
    if [[ "$DISTRO" == "arch" ]]; then
        echo "##########   Setting up Pacman with color and parallel downloads   ##########"
        pacman_setup
        echo "##########   Installing packages needed for setup   ##########"
        install_needed_pkgs
        echo "##########   Adding user to sudoers, no password needed   ##########"
        add_user_to_sudoers
        echo "##########   Finding fastest mirrors   ##########"
        update_mirrorlist
        echo "##########   Setting default shell to zsh   ##########"
        set_default_shell
    else
        echo "This script is intended for Arch Linux."
        exit 1
    fi
elif [[ "$(uname)" == "Darwin" ]]; then
    echo "This is a macOS system. Skipping linux setup."
else
    echo "Unknown system."
fi

# Setup pacman with color and parallel downloads
pacman_setup() {
    sudo sed -i 's/#Color/Color/' /etc/pacman.conf
    sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf
}

# Install packages needed to setup the system
install_needed_pkgs() {
    sudo pacman -S --noconfirm --needed base-devel chezmoi git rust zsh
}

# Add user to sudoers NOPASSWD
add_user_to_sudoers() {
    sudo echo "$who_am_i ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/00_$who_am_i
}

# Install AUR helper paru
install_paru() {
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
}

# Install rate-mirrors and update the mirrorlist
update_mirrorlist() {
    paru -S --noconfirm --needed rate-mirrors-bin
    rate-mirrors --country CA,US arch | sudo tee /etc/pacman.d/mirrorlist
}

# Set the default shell to zsh
set_default_shell() {
    sudo chsh -s $(which zsh) $who_am_i
}

# Get the dotfiles and apply them
chezmoi init --apply $git_hub_username
