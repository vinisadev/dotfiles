#!/bin/bash

PACKAGES=(
  "gnome-disk-utility"
)

for package in "${PACKAGES[@]}"; do
  install_package "$package"
done