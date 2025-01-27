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
  "gnucash"
  "go"
  "godot"
  "lazygit"
  "libreoffice-still"
  "neovim"
  "obsidian"
  "onefetch"
  "rustup"
  "stow"
  "thunderbird"
)

for package in "${PACKAGES[@]}"; do
  install_package "$package"
done