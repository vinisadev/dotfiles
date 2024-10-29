#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Print colored output
print_color() {
  printf "${2}${1}${NC}\n"
}

# Check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install a package using pacman
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

print_color "Bootstrap process completed successfully!" "$GREEN"
print_color "Please log out and log back in for all changes to take effect." "$YELLOW"
