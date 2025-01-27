#!/bin/bash

PACKAGES=(
  "discord"
  "flameshot"
  "godot"
  "gnome-disk-utility"
  "rustup"
)

for package in "${PACKAGES[@]}"; do
  install_package "$package"
done