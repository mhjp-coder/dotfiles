#!/bin/bash

# linux
##########################################
# Configure New Arch Linux
##########################################
set -e

# Check if the script is being run as root
if [ "$EUID" -eq 0 ]; then
    echo "\\nPlease do nut run this script as root.\\n"
    exit 1
fi

# Prompt the user to enter a username
read -p "\\nPlease Enter the GitHub username to get the dot files from: " git_hub_username

# Get the current user
who_am_i=$(whoami)

# Setup pacman with color and parallel downloads
pacman_setup() {
    echo "\\n##########   Setting up Pacman with color and parallel downloads   ##########\\n"
    sudo sed -i 's/#Color/Color/' /etc/pacman.conf
    sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf
    echo "\\n##########   Pacman config done   ##########\\n"
}

# Install packages needed to setup the system
install_needed_pkgs() {
    echo "\\n##########   Installing packages needed for setup   ##########\\n"
    sudo pacman -S --noconfirm --needed base-devel chezmoi git rust zsh
    echo "\\n##########   Package installs done   ##########\\n"
}

# Add user to sudoers NOPASSWD
add_user_to_sudoers() {
    echo "\\n##########   Adding user to sudoers, no password needed   ##########\\n"
    sudo echo "$who_am_i ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/00_$who_am_i
    echo "\\n##########   User added to sudoers   ##########\\n"

}

# Install AUR helper paru
install_paru() {
    if ! command -v paru 2>&1 >/dev/null
    then
        echo "\\n########### Installing paru AUR helper ###########\\n"
        rm -rf paru
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg --syncdeps --install --noconfirm --needed
        cd ..
        rm -rf paru
        echo "\\n##########   Paru install complete   ##########\\n"
    fi
}

# Install rate-mirrors and update the mirrorlist
update_mirrorlist() {
    echo "\\n##########   Finding fastest mirrors   ##########\\n"
    paru -S --noconfirm --needed rate-mirrors-bin
    rate-mirrors --country CA,US arch | sudo tee /etc/pacman.d/mirrorlist
    echo "\\n##########   Mirrorlist updated   ##########\\n"
}

# Set the default shell to zsh
set_default_shell() {
    echo "\\n##########   Setting default shell to zsh   ##########\\n"
    sudo chsh -s $(which zsh) $who_am_i
    echo "\\n##########   Default shell set to zsh   ##########\\n"
}

# Lets get started with the system setup
if [[ "$(uname)" == "Linux" ]]; then
    DISTRO=$(grep '^ID=' /etc/os-release | cut -d'=' -f2)
    echo "\\nThis is a Linux system running $DISTRO.\\n"
    if [[ "$DISTRO" == "arch" ]]; then
        # Setup pacman
        pacman_setup
        # Install needed packages
        install_needed_pkgs
        # Add user to sudoers
        add_user_to_sudoers
        # Install paru
        install_paru
        # Update mirrorlist
        update_mirrorlist
        # Set default shell to zsh
        set_default_shell
    else
        echo "\\nThis script is intended for Arch Linux.\\n"
        exit 1
    fi
elif [[ "$(uname)" == "Darwin" ]]; then
    echo "\\nThis is a macOS system. Skipping linux setup.\\n"
else
    echo "\\nUnknown system.\\n"
fi

# Get the dotfiles and apply them
chezmoi init --apply $git_hub_username
