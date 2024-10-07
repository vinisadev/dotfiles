#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
  printf "${2}${1}${NC}\n"
}

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install a package using pacman
install_package() {
  if ! pacman -Qi "$1" >/dev/null 2>&1; then
    print_color "Installing $1..." "$YELLOW"
    sudo pacman -S --noconfirm "$1"
  else
    print_color "$1 is already installed." "$GREEN"
  fi
}

# Check if running on Arch Linux
if [ ! -f /etc/arch-release ]; then
  print_color "This script is intended for Arch Linux only." "$RED"
  exit 1
fi

# Update system
print_color "Updating system..." "$YELLOW"
sudo pacman -Syu --noconfirm

# Install git if not already installed
install_package "git"

# Clone dotfiles repository
DOTFILES_REPO="https://github.com/vinisadev/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  print_color "Cloning dotfiles repository..." "$YELLOW"
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  print_color "Dotfiles directory already exists. Pulling latest changes..." "$YELLOW"
  cd "$DOTFILES_DIR" && git pull
fi

# Install essential packages
PACKAGES=(
  "stow"
)

for package in "${PACKAGES[@]}"; do
  install_package "$package"
done

# Use GNU Stow to symlink dotfiles
print_color "Using GNU Stow to symlink dotfiles..." "$YELLOW"
cd "$DOTFILES_DIR"

STOW_DIRS=(
  "qtile"
)

for dir in "${STOW_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    print_color "Stowing $dir..." "$GREEN"
    stow -v -R -t "$HOME" "$dir"
  else
    print_color "Directory $dir not found in dotfiles." "$RED"
  fi
done

# Install AUR helper (paru)
if ! command_exists paru; then
  print_color "Installing paru AUR helper..." "$YELLOW"
  sudo pacman -S --needed base-devel
  git clone https://aut.archlinux.org/paru.git
  cd paru
  makepkg -si --noconfirm
  cd ..
  rm -rf paru
else
  print_color "Paru is already installed." "$GREEN"
fi

# Install AUR packages
AUR_PACKAGES=(

)

for package in "${AUR_PACKAGES[@]}"; do
  if ! paru -Qi "$package" >/dev/null 2>&1; then
    print_color "Installing $package from AUR..." "$YELLOW"
    paru -S --noconfirm "$package"
  else
    print_color "$package is already installed." "$GREEN"
  fi
done

# Set zsh as the default shell
if [ "$SHELL" != "/usr/bin/zsh" ]; then
  print_color "Setting zsh as the default shell..." "$YELLOW"
  chsh -s /usr/bin/zsh
fi

print_color "Bootstrap process completed successfully!" "$GREEN"
print_color "Please log out and log back in for all changes to take effect." "$YELLOW"