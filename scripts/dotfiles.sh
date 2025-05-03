#!/bin/bash

DOTFILES_REPO="https://github.com/vinisadev/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  print_color "Cloning dotfiles repository..." "$YELLOW"
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  print_color "Dotfiles directory already exists. Pulling latest changes..." "$YELLOW"
  pushd "$DOTFILES_DIR" >/dev/null
  git pull
  popd >/dev/null
fi

# Use GNU Stow to symlink dotfiles
pushd "$DOTFILES_DIR" >/dev/null

# Backup and remove existing config directories if they exist
STOW_DIRS=(
  "nvim"
)

for dir in "${STOW_DIRS[@]}"; do
  config_path="$HOME/.config/${dir}"
  if [ -d "$config_path" ]; then
    print_color "Backing up existing $config_path..." "$YELLOW"
    mv "$config_path" "${config_path}.backup.$(date +%Y%m%d_%H%M%S)"
  fi
done

# Now stow the directories
for dir in "${STOW_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    print_color "Stowing $dir..." "$GREEN"
    stow -v -R -t "$HOME" "$dir"
    if [ $? -eq 0 ]; then
      print_color "$dir stowed successfully." "$GREEN"
    else
      print_color "Failed to stow $dir. Please check for conflicts." "$RED"
    fi
  else
    print_color "Directory $dir not found in dotfiles." "$RED"
  fi
done

popd >/dev/null