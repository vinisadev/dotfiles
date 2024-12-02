#!/bin/bash

PACKAGES=(
    "dbeaver"
    "discord"
    "docker"
    "docker-compose"
    "flameshot"
    "gnome-disk-utility"
    "godot"
    "go"
    "lazygit"
    "libreoffice-still"
    "neovim"
    "rustup"
    "stow"
    "thunderbird"
)

for package in "${PACKAGES[@]}"; do
    install_package "$package"
done

# Install steam with user intervention for drivers selection
if ! command_exists steam; then
    print_color "Installing steam..." "$YELLOW"
    sudo pacman -S steam
else
    print_color "Steam is already installed..." "$GREEN"
fi
