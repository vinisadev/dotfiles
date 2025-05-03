#!/bin/bash

PACKAGES=(
  "cmake"
  "dbeaver"
  "discord"
  "docker"
  "docker-buildx"
  "docker-compose"
  "flameshot"
  "gnome-disk-utility"
  "godot"
  "rustup"
)

for package in "${PACKAGES[@]}"; do
  install_package "$package"
done