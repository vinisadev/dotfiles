#!/bin/bash

if ! command_exists git; then
  print_color "Installing git..." "$YELLOW"
  install_package "git"

  print_color "Setting default git branch to master..." "$YELLOW"
  git config --global init.defaultBranch master
else
  print_color "git is already installed." "$GREEN"
  print_color "Setting default git branch to master..." "$YELLOW"
  git config --global init.defaultBranch master
fi