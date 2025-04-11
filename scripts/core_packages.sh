#!/bin/bash

PACKAGES=(
    "cmake"
    "dbeaver"
    "discord"
    "docker"
    "docker-buildx"
    "docker-compose"
    "flameshot"
    "godot"
    "gnome-disk-utility"
    "rustup"
)

for package in "${PACKAGES[@]}"; do
    install_package "$package"
done