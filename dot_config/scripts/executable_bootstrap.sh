#!/bin/bash

# Install yay
pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install packages from pkglist.txt
yay -S --noconfirm --needed - < ~/dot_config/pkglist.txt

# Install AUR packages
yay -S
