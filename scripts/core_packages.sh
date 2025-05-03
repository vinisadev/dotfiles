#!/bin/bash

PACKAGES=(
  "discord"
  "flameshot"
  "gnome-disk-utility"
)

for package in "${PACKAGES[@]}"; do
  install_package "$package"
done