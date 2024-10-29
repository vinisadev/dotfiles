#!/bin/bash

if ! command_exists git; then
  print_color "Installing git..." "$YELLOW"
  install_package "git"

  print_color "Configuring git user and email..." "$YELLOW"
  git config --global user.name "Vincenzo Fehring"
  git config --global user.email "vinfehring@gmail.com"
  print_color "Setting default git branch to master..." "$YELLOW"
  git config --global init.defaultBranch master
else
  print_color "git is already installed." "$GREEN"
  print_color "Configuring git user and email..." "$YELLOW"
  git config --global user.name "Vincenzo Fehring"
  git config --global user.email "vinfehring@gmail.com"
  print_color "Setting default git branch to master..." "$YELLOW"
  git config --global init.defaultBranch master
fi
