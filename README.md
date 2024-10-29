# Arch Linux Bootstrap Script

This repository contains a bootstrap script for setting up a new Arch Linux installation with my preferred configurations and tools. The script automates the installation of packages, configuration of development tools, and setup of dotfiles.

## ⚠️ Important Security Notice

Before running this or any bootstrap script, you should:

1. **Read and understand the script**: Take time to review the code to understand what changes it will make to your system
2. **Verify the source**: Ensure you trust the source of the script
3. **Audit the packages**: Review the list of packages that will be installed
4. **Backup your data**: While this script shouldn't affect existing data, it's always good practice to backup before major system changes

## 🔍 What the Script Does

The script performs the following operations:

### System Updates and Base Configuration
- Updates the system packages using pacman
- Sets the default git branch to master
- Clones the dotfiles repository

### Package Installation
#### Core Packages (via pacman)
- dbeaver
- discord
- docker
- docker-compose
- flameshot
- gnome-disk-utility
- godot
- go
- libreoffice-still
- neovim
- rustup
- steam
- stow

#### AUR Packages (via paru)
- doppler-cli-bin
- google-chrome
- railwayapp-cli
- slack-desktop
- visual-studio-code-bin
- yaak-bin
- zen-browser-avx2-bin

### Development Environment Setup
- Installs and configures Rust (stable toolchain)
- Sets up Go environment and PATH
- Installs NVM (Node Version Manager) and the latest Node.js
- Configures Docker user permissions and services

### Configuration Management
- Uses GNU Stow to manage dotfiles
- Configures zsh as the default shell
- Sets up various PATH and environment variables

## 📋 Prerequisites

Before running this script, ensure you have:
1. A fresh Arch Linux installation
2. An internet connection
3. Sudo privileges
4. Basic understanding of Arch Linux and shell scripts

## 🚀 Usage

1. **Download the Script**
   ```bash
   curl -O https://raw.githubusercontent.com/vinfehring/dotfiles/main/bootstrap.sh
   ```

2. **Make it Executable**
   ```bash
   chmod +x bootstrap.sh
   ```

3. **Review the Script (IMPORTANT)**
   ```bash
   less bootstrap.sh
   ```

4. **Run the Script**
   ```bash
   ./bootstrap.sh
   ```

5. **After Script Completion**
   - Log out and log back in for all changes to take effect
   - If prompted, manually change your shell to zsh:
     ```bash
     chsh -s /usr/bin/zsh
     ```

## ⚙️ Customization

To customize this script for your own use:

1. Fork this repository
2. Modify the `DOTFILES_REPO` variable to point to your dotfiles repository
3. Update the package lists in `PACKAGES` and `AUR_PACKAGES` arrays
4. Adjust the Stow directories in `STOW_DIRS` array to match your dotfiles structure
5. Modify any environment variables or configurations to match your preferences
6. Modify git configuration values on lines 49, 50, 54, 55

## 📁 Directory Structure

For the script to work correctly, your dotfiles repository should follow this structure:
```
dotfiles/
├── nvim/            # Example configuration directory
│   └── .config/
│       └── nvim/
│           └── init.lua
├── zsh/
│   └── .zshrc
└── other_configs/
```

## ⏱️ Performance

The script includes timing information and will display the total execution time upon completion. The duration can vary based on:
- Your internet connection speed
- System specifications
- Number of packages being installed
- AUR package compilation time

## 🔧 Troubleshooting

Common issues and solutions:

1. **Shell Change Failed**
   - The script will provide instructions to manually change your shell to zsh
   - Take your time when entering the password for `chsh`

2. **Package Installation Errors**
   - Ensure you have a stable internet connection
   - Try running `sudo pacman -Syu` manually first
   - Check if the package names are still valid

3. **Docker Configuration**
   - If Docker group membership isn't working, log out and back in
   - Verify Docker service status with `systemctl status docker`

## 🤝 Contributing

Feel free to:
1. Fork this repository
2. Create a feature branch
3. Submit a Pull Request with your improvements

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

## 🔒 Security

If you discover any security-related issues, please email [your-email@example.com] instead of using the issue tracker.

## 📝 Notes

- This script is specifically designed for Arch Linux and may not work on other distributions
- Some manual configuration may still be required after running the script
- Always check the script for updates before running it on a new system
- Consider creating a backup or snapshot before running the script