#!/bin/bash

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