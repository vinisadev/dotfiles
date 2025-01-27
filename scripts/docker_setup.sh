#!/bin/bash

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
    print_color "Docker is installed. Skipping Docker configuration." "$RED"
  fi
)