#!/bin/bash

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
        nvm install 22.12.0 # This installs the latest version of Node.js
        nvm use node # Use the installed version
    else
        print_color "Node.js is already installed. Checking for updated..." "$YELLOW"
        nvm install 22.12.0 --reinstall-packages-from=node # This updates node.js to the latest version
    fi

    print_color "Node.js version: $(node --version)" "$GREEN" # Print the installed Node.js version
    print_color "npm version: $(npm --version)" "$GREEN" # Print the installed npm version
)