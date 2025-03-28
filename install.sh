#!/usr/bin/env bash

# This script is intended to be run on a fresh Arch Linux installation
# or MacOS system to set up the environment with necessary packages and configurations.
# It installs packages, sets up the system, and applies dotfiles using chezmoi.
# It is not intended to be run as root.

set -e

# Check if the script is being run as root
if [ "$EUID" -eq 0 ]; then
    echo -e "\nPlease do not run this script as root."
    exit 1
fi


# Prompt the user to enter a username
echo
read -p "Please Enter the GitHub username to get the Chezmoi dotfiles from: " git_hub_username

# Get the current user
who_am_i=$(whoami)

# Setup pacman with color and parallel downloads
pacman_setup() {
    echo -e "\n##########   Setting up Pacman with color and parallel downloads   ##########"
    sudo sed -i '/^#Color/s/^#//' /etc/pacman.conf
    sudo sed -i '/^#ParallelDownloads = 5/s/^#//' /etc/pacman.conf
}

# Install packages needed to setup the system
install_needed_pkgs() {
    local os=$1
    echo -e "\n##########   Installing packages needed for setup   ##########"
    if [[ "$os" == "arch" ]]; then
        echo -e "\n##########   Installing packages needed for arch   ##########"
        sudo pacman -S --noconfirm --needed base-devel chezmoi git rust fish
    elif [[ "$os" == "darwin" ]]; then
        echo -e "\n##########   Installing packages needed for macOS   ##########"
        brew install chezmoi git rust fish
    fi
}

# Add user to sudoers NOPASSWD
add_user_to_sudoers() {
    echo -e "\n##########   Adding user to sudoers, no password needed   ##########"
    sudo echo -e "$who_am_i ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/00_$who_am_i
}

# Disable debug for makepkg
disable_mkpkg_debug() {
    echo -e "\n##########   Disabling debug for makepkg   ##########"
    sudo sed -i '/^OPTIONS=.*\bdebug\b/s/\bdebug\b/!debug/' /etc/makepkg.conf
}

# Install Homebrew
install_homebrew() {
    if ! command -v brew 2>&1 >/dev/null
    then
        echo -e "\n########### Installing Homebrew ###########"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

# Install AUR helper paru
install_paru() {
    if ! command -v paru 2>&1 >/dev/null
    then
        echo -e "\n########### Installing paru AUR helper ###########"
        #TODO: I dont like this -rf, need to error check instead
        rm -rf paru
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg --syncdeps --install --noconfirm --needed
        cd ..
        #TODO: Same As above
        rm -rf paru
    fi
}

# Install rate-mirrors and update the mirrorlist
update_mirrorlist() {
    echo -e "\n##########   Finding fastest mirrors   ##########"
    paru -S --noconfirm --needed rate-mirrors-bin
    rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist
}

# Lets get started with the system setup
if [[ "$(uname)" == "Linux" ]]; then
    DISTRO=$(grep '^ID=' /etc/os-release | cut -d'=' -f2)
    echo -e "\nThis is a Linux system running $DISTRO."
    if [[ "$DISTRO" == "arch" ]]; then
        # Setup pacman
        pacman_setup
        # Install needed packages
        install_needed_pkgs arch
        # Add user to sudoers
        add_user_to_sudoers
        # disable debug for makepkg
        disable_mkpkg_debug
        # Install paru
        install_paru
        # Update mirrorlist
        update_mirrorlist
    else
        echo -e "\nThis script is intended for Arch Linux."
        exit 1
    fi
elif [[ "$(uname)" == "Darwin" ]]; then
    echo -e "\nThis is a macOS system. Skipping linux setup."
    # Check if Homebrew is installed
    install_homebrew
    # Install packages needed for setup
    echo -e "\n##########   Installing packages needed for setup   ##########"
    install_needed_pkgs darwin
else
    echo -e "\nUnknown system. Not Arch Linux or macOS."
fi

# Remove the existing chezmoi directory
#TODO: another -rf, here we should ask the user if this is ok
[[ -d $HOME/.local/share/chezmoi ]] && rm -rf $HOME/.local/share/chezmoi
# Get the dotfiles and apply them
chezmoi init $git_hub_username --apply
