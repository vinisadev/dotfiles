# Arch Linux Dotfiles Bootstrap Script

This repository contains a module bootstrap system for setting up a new Arch Linux installation with my preferred configurations and tools. The script architecture is divided into individual components for better maintainability and flexibility.

## ⚠️ Important Security Notice

Before running this or any bootstrap script, you should:

1. **Read and understand the scripts**: Take time to review all scripts in the `scripts/` directory to understand what changes they will make to your system
2. **Verify the source**: Ensure you trust the source of all scripts
3. **Audit the packages**: Review the list of packages that will be installed in `core_packages.sh` and `aur_setup.sh`
4. **Backup your data**: While these scripts shouldn't affect existing data, it's always good practice to backup before major system changes

## 🗂️ Directory Structure

```
dotfiles/
├── bootstrap.sh           # Main orchestration script
└── scripts/
    ├── aur_setup.sh        # AUR helper and AUR package installation
    ├── core_packages.sh    # Core package installation
    ├── docker_setup.sh     # Configure Docker service for non-root users
    ├── dotfiles.sh         # Personal configurations
    ├── git_config.sh       # Git configuration
    ├── node_setup.sh       # Install NVM and Node LTS
    ├── rust_setup.sh       # Install the Rust Stable Toolchain
    ├── shell_setup.sh      # Configure ZSH
    ├── steam_setup.sh      # Setup Steam for Gaming
    ├── system_update.sh    # System update functionality
    └── utils.sh            # Utility functions and common variables
```

## 🔍 What Each Script Does

### bootstrap.sh
- Orchestrates the execution of all other scripts
- Maintains execution order
- Provides timing information
- Handles errors and script validation

### aur_setup.sh
Installs and configures AUR helper (paru) and AUR packages:
- appimagelauncher
- brother-hll2315dw
- google-chrome
- insomnia-bin
- railwayapp-cli
- slack-desktop
- visual-studio-code-bin
- zoom

### core_packages.sh
Installs core packages via pacman:
- cmake
- dbeaver
- discord
- docker
- docker-buildx
- docker-compose
- ducker
- fastfetch
- flameshot
- gnome-disk-utility
- gnucash
- go
- godot
- lazygit
- libreoffice-still
- neovim
- obsidian
- onefetch
- rustup
- stow
- thunderbird

### docker_setup.sh
- Configures Docker permissions
- Sets up Docker service
- Adds user to Docker group

### dotfiles.sh
- Clones this repository
- Uses GNU Stow to manage dotfiles
- Handles backup of existing configurations
- Currently manages:
  - nvim

### git_config.sh
- Sets the default git branch to master
- Configures basic git settings

### node_setup.sh
- Installs NVM (Node Version Manager)
- Installs latest Node.js
- Configures Node.js environment

### rust_setup.sh
- Installs Rust stable toolchain
- Configures Rust environment

### shell_setup.sh
- Configures zsh as default shell
- Sets up PATH and environment variables

### steam_setup.sh
- Installs Steam with user intervention for driver selection

### system_update.sh
- Updates the system packages using pacman

### utils.sh
- Contains common utility functions
- Defines color variables for output
- Provides package installation helpers

## 📋 Prerequisites

Before running these scripts, ensure you have:
1. A fresh Arch Linux installation
2. An internet connection
3. Sudo privileges
4. Basic understanding of Arch Linux and shell scripts

## 🚀 Usage

### Running the Complete Bootstrap

1. **Clone the Repository**
```bash
git clone https://github.com/vinisadev/dotfiles.git
cd dotfiles
```

2. **Make Scripts Executable**
```bash
  chmod +x bootstrap.sh
  chmod +x scripts/*.sh
```

3. **Review the Scripts (IMPORTANT)**
```bash
  # Review bootstrap script
  less bootstrap.sh
  # Review individual scripts
  less scripts/*.sh
```

4. **Run the Main Script**
```bash
  ./bootstrap.sh
```

## ⏱️ Performance

The script includes timing information and will display the total execution time upon completion. The duration can vary based on:
- Your internet connection speed
- System specifications
- Number of packages being installed
- AUR package compilation time

## 🤝 Contributing

1. Fork this repository
2. Create a feature branch
3. Submit a Pull Request with your improvements

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

## 🔒 Security

If you discover any security-related issues, please email vinfehring@gmail.com instead of using the issue tracker.

## 📝 Notes

- These scripts are specifically designed for Arch Linux
- Some manual configuration may still be required after running the scripts
- Always check the scripts for updates before running them on a new system
- Consider creating a backup or snapshot before running any scripts
