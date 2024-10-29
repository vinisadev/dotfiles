#!/bin/bash

# Record start time
start_time=$(date +%s)

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

if ! command_exists git; then
  print_color "Installing git..." "$YELLOW"
  install_package "git"

  print_color "Configuring git user and email..." "$YELLOW"
  git config --global user.name "Vincenzo Fehring"
  git config --global user.email "vinfehring@gmail.com"
else
  print_color "git is already installed." "$GREEN"
  print_color "Configuring git user and email..." "$YELLOW"
  git config --global user.name "Vincenzo Fehring"
  git config --global user.email "vinfehring@gmail.com"
fi

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
  "discord"
  "docker"
  "docker-compose"
  "flameshot"
  "gnome-disk-utility"
  "godot"
  "go"
  "libreoffice-still"
  "neovim"
  "rustup"
  "stow"
)

for package in "${PACKAGES[@]}"; do
  install_package "$package"
done

# Install steam with user intervention for drivers selection
if ! command_exists steam; then
  print_color "Installing steam..." "$YELLOW"
  sudo pacman -S steam
else
  print_color "Steam is already installed..." "$GREEN"
fi

# Use GNU Stow to symlink dotfiles
print_color "Using GNU Stow to symlink dotfiles..." "$YELLOW"
cd "$DOTFILES_DIR"

STOW_DIRS=(
  "nvim"
)

for dir in "${STOW_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    print_color "Stowing $dir..." "$GREEN"
    stow -v -R -t "$HOME" "$dir"
  else
    print_color "Directory $dir not found in dotfiles." "$RED"
  fi
done

# Install rust stable toolchain
print_color "Installing rust stable toolchain..." "$YELLOW"
rustup install stable

# Append custom content to .zshrc-personal
print_color "Appending Go PATH to .zshrc..." "$YELLOW"
ZSHRC="$HOME/.zshrc-personal"
CUSTOM_CONTENT="
# Go PATH configuration added by bootstrap script
export PATH=\"\$PATH:\$(go env GOBIN):\$(go env GOPATH)/bin\"

# NVM configuration added by bootstrap script
export NVM_DIR=\"\$HOME/.nvm\"
[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"  # This loads nvm
[ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\"  # This loads nvm bash_completion
"

print_color "Checking for .zshrc-personal in HOME..." "$YELLOW"
[[ -f ~/.zshrc-personal ]] && . ~/.zshrc-personal

if ! grep -q "Go PATH configuration added by bootstrap script" "$ZSHRC"; then
  echo "$CUSTOM_CONTENT" >> "$ZSHRC"
  print_color "Go PATH configuration added to .zshrc" "$GREEN"
else
  print_color "Go PATH configuration already exists in .zshrc-personal. Skipping..." "$YELLOW"
fi

# Install NVM
if [ ! -d "$HOME/.nvm" ]; then
  print_color "Installing NVM..." "$YELLOW"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
else
  print_color "NVM is already installed. Skipping installation." "$GREEN"
fi

# Source NVM and install Node.js in a subshell
print_color "Installing latest Node.js version..." "$YELLOW"
(
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads NVM

  if ! command_exists node; then
    print_color "Installing latest Node.js version..." "$YELLOW"
    nvm install node # This installs the latest version of Node.js
    nvm use node # Use the installed version
  else
    print_color "Node.js is already installed. Checking for updates..." "$YELLOW"
    nvm install node --reinstall-packages-from=node # This updates node.js to the latest version
  fi

  print_color "Node.js version: $(node --version)" "$GREEN" # Print the installed Node.js version
  print_color "npm version: $(npm --version)" "$GREEN" # Print the installed npm version
)

# Docker configuration in a subshell
(
  print_color "Configuring Docker..." "$YELLOW"

  # Check if Docker is installed
  if command_exists docker; then
    # Post install configuration for Docker
    sudo usermod -aG docker $USER

    # Enable docker service
    print_color "Enabling docker service..." "$YELLOW"
    sudo systemctl enable docker

    # Start docker service
    print_color "Starting docker service..." "$YELLOW"
    sudo systemctl start docker

    print_color "Docker configuration completed." "$GREEN"
    print_color "Please log out and log back in for Docker group changes to take effect." "$YELLOW"
  else
    print_color "Docker is not installed. Skipping Docker configuration." "$RED"
  fi
)

# Install AUR helper (paru)
if ! command_exists paru; then
  print_color "Installing paru AUR helper..." "$YELLOW"
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si --noconfirm
  cd ..
  rm -rf pary
else
  print_color "paru is already installed." "$GREEN"
fi

# Install AUR packages
AUR_PACKAGES=(
  "doppler-cli-bin"
  "google-chrome"
  "slack-desktop"
  "railwayapp-cli"
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
if [ "$SHELL" != "/bin/zsh" ]; then
  print_color "Setting zsh as the default shell..." "$YELLOW"
  chsh -s /bin/zsh
fi

# Record end time
end_time=$(date +%s)

# Calculate duration
duration=$((end_time - start_time))

# Convert duration to hours, minutes, and seconds
hours=$((duration / 3600))
minutes=$(( (duration % 3600) / 60 ))
seconds=$((duration % 60))

print_color "Bootstrap process completed successfully!" "$GREEN"
print_color "Total execution time: ${hours}h ${minutes}m ${seconds}s" "$YELLOW"
print_color "Please log out and log back in for all changes to take effect." "$YELLOW"
