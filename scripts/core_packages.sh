#!/bin/bash

PACKAGES=(
  "discord"
  "flameshot"
  "gnome-disk-utility"
  "godot"
)

for package in "${PACKAGES[@]}"; do
  install_package "$package"
done