#!/bin/bash

PACKAGES=(
  "cmake"
  "discord"
  "flameshot"
  "gnome-disk-utility"
  "godot"
  "rustup"
)

for package in "${PACKAGES[@]}"; do
  install_package "$package"
done