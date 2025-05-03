#!/bin/bash

if ! command_exists paru; then
  print_color "Installing paru AUR helper..." "$YELLOW"
  sudo pacman -S --needed base-devel

  # Create temporary directory and remember its location
  temp_dir=$(mktemp -d)
  pushd "$temp_dir" >/dev/null

  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si --noconfirm

  # Return to original directory and clean up
  popd >/dev/null
  rm -rf "$temp_dir"
else
  print_color "paru is already installed." "$GREEN"
fi

# Install AUR packages
AUR_PACKAGES=()

for package in "${AUR_PACKAGES[@]}"; do
  if ! paru -Qi "$package" >/dev/null 2>&1; then
    print_color "Installing $package from AUR..." "$YELLOW"
    paru -S --noconfirm "$package"
  else
    print_color "$package is already installed." "$GREEN"
  fi
done