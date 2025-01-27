#!/bin/bash

PACKAGES=(
  "cmake"
  "dbeaver"
  "discord"
  "docker"
  "docker-buildx"
  "docker-compose"
  "ducker"
  "fastfetch"
  "flameshot"
  "gnome-disk-utility"
  "go"
  "godot"
  "lazygit"
  "libreoffice-still"
  "neovim"
  "rustup"
)

for package in "${PACKAGES[@]}"; do
  install_package "$package"
done