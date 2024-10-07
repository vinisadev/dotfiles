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

# Set default git branch to master
print_color "Setting default git branch to master..." "$YELLOW"
git config --global init.defaultBranch master

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
  "dbeaver"
  "discord"
  "docker"
  "docker-compose"
  "flameshot"
  "gnome-disk-utility"
  "go"
  "godot"
  "lazygit"
  "libreoffice-still"
  "neovim"
  "rustup"
  "steam"
  "stow"
)

for package in "${PACKAGES[@]}"; do
  install_package "$package"
done

# Install Rust Stable Channel
print_color "Installing Rust Stable Toolchain..." "$YELLOW"
rustup install stable

# Docker configuration in a subshell
(
  print_color "Configuring Docker..." "$YELLOW"

  # Check if Docker is installed
  if command_exists docker; then
    # Post install configuration for Docker
    sudo usermod -aG docker $USER

    # Enable Docker service
    print_color "Enabling Docker service..." "$YELLOW"
    sudo systemctl enable docker

    # Start Docker service
    print_color "Starting Docker service..." "$YELLOW"
    sudo systemctl start docker

    print_color "Docker configuration completed." "$GREEN"
    print_color "Please log out and log back in for Docker group changes to take effect." "$YELLOW"
  else
    print_color "Docker is not installed. Skipping Docker configuration." "$RED"
  fi
)

# Use GNU Stow to symlink dotfiles
print_color "Using GNU Stow to symlink dotfiles..." "$YELLOW"
cd "$DOTFILES_DIR"

STOW_DIRS=(
  "nvim"
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

# Append new exports to .zshrc
print_color "Appending custom content to .zshrc..." "$YELLOW"
ZSHRC="$HOME/.zshrc"
CUSTOM_CONTENT="
# Go PATH configuration added by bootstrap script
export PATH=\"\$PATH:\$(go env GOBIN):\$(go env GOPATH)/bin\"

export NVM_DIR=\"\$HOME/.nvm\"
[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\" # This loads nvm
[ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\" # This loads nvm bash_completions
"

if ! grep -q "$CUSTOM_CONTENT" "$ZSHRC"; then
  echo "$CUSTOM_CONTENT" >> "$ZSHRC"
  print_color "Go PATH configuration added to .zshrc" "$GREEN"
else
  print_color "Go PATH configuration already exists in .zshrc. Skipping..." "$YELLOW"
fi

# Configure nvm
if [ ! -d "$HOME/.nvm" ]; then
  print_color "Installing nvm..." "$YELLOW"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  print_color "NVM is already installed. Skipping installation." "$GREEN"
fi

# Source NVM and install Node.js in a subshell
print_color "Configuring Node.js..." "$YELLOW"
(
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  
  if ! command_exists node; then
    print_color "Installing latest Node.js version..." "$YELLOW"
    nvm install node # This installs the latest version of Node.js
    nvm use node # Use the installed version
  else
    print_color "Node.js is already installed. Checking for updates..." "$YELLOW"
    nvm install node --reinstall-packages-from=node # This updates Node.js to the lastest version
  fi

  print_color "Node.js version: $(node --version)" "$GREEN" # Print the installed Node.js version
  print_color "NPM version: $(npm --version)" "$GREEN" # Print the installed npm version
)

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
  "google-chrome"
  "insomnia"
  "railwayapp-cli"
  "slack-desktop"
  "visual-studio-code-bin"
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