#!/bin/bash

# Install steam with user intervention for drivers selection
if ! command_exists steam; then
  print_color "Installing steam..." "$YELLOW"
  sudo pacman -S steam
else
  print_color "Steam is already installed..." "$GREEN"
fi