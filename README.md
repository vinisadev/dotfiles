# Arch Linux Bootstrap Script

This repository contains a modular bootstrap system for setting up a new Arch Linux installation with my preferred configurations and tools. The script architecture is divided into individual components for better maintainability and flexibility.

## ⚠️ Important Security Notice

Before running this or any bootstrap script, you should:

1. **Read and understand the scripts**: Take time to review all scripts in the `scripts/` directory to understand what changes they will make to your system
2. **Verify the source**: Ensure you trust the source of all scripts
3. **Audit the packages**: Review the list of packages that will be installed in `core_packages.sh` and `aur_setup.sh`
4. **Backup your data**: While these scripts shouldn't affect existing data, it's always good practice to backup before major system changes

## 🗂️ Directory Structure

```
bootstrap/
├── main.sh                 # Main orchestration script
└── scripts/
    ├── utils.sh           # Utility functions and common variables
    ├── system_update.sh   # System update functionality
    ├── git_config.sh      # Git configuration
    ├── core_packages.sh   # Core package installation
    ├── dotfiles.sh        # Dotfiles management
    ├── rust_setup.sh      # Rust installation and configuration
    ├── node_setup.sh      # Node.js and NVM setup
    ├── docker_setup.sh    # Docker configuration
    ├── aur_setup.sh       # AUR helper and AUR package installation
    └── shell_setup.sh     # Shell configuration
```

## 🔍 What Each Script Does

### main.sh
- Orchestrates the execution of all other scripts
- Maintains execution order
- Provides timing information
- Handles errors and script validation

### utils.sh
- Contains common utility functions
- Defines color variables for output
- Provides package installation helpers

### system_update.sh
- Updates the system packages using pacman

### git_config.sh
- Sets the default git branch to master
- Configures basic git settings

### core_packages.sh
Installs core packages via pacman:
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

### dotfiles.sh
- Clones the dotfiles repository
- Uses GNU Stow to manage dotfiles
- Handles backup of existing configurations
- Currently manages:
  - qtile
  - nvim

### rust_setup.sh
- Installs Rust stable toolchain
- Configures Rust environment

### node_setup.sh
- Installs NVM (Node Version Manager)
- Installs latest Node.js
- Configures Node.js environment

### docker_setup.sh
- Configures Docker permissions
- Sets up Docker service
- Adds user to Docker group

### aur_setup.sh
Installs and configures AUR helper (paru) and AUR packages:
- doppler-cli-bin
- google-chrome
- railwayapp-cli
- slack-desktop
- visual-studio-code-bin
- yaak-bin
- zen-browser-avx2-bin

### shell_setup.sh
- Configures zsh as default shell
- Sets up PATH and environment variables

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
   cd dotfiles/bootstrap
   ```

2. **Make Scripts Executable**
   ```bash
   chmod +x main.sh
   chmod +x scripts/*.sh
   ```

3. **Review the Scripts (IMPORTANT)**
   ```bash
   # Review main script
   less main.sh
   # Review individual scripts
   less scripts/*.sh
   ```

4. **Run the Main Script**
   ```bash
   ./main.sh
   ```

### Running Individual Components

You can run individual scripts if you only need specific functionality:

```bash
# First source the utilities
source ./scripts/utils.sh

# Then run any individual script
./scripts/system_update.sh
./scripts/docker_setup.sh
# etc.
```

## ⚙️ Customization

To customize these scripts for your own use:

1. **Fork this repository**

2. **Modify Package Lists**
   - Edit `scripts/core_packages.sh` for pacman packages
   - Edit `scripts/aur_setup.sh` for AUR packages

3. **Update Dotfiles Configuration**
   - Edit `scripts/dotfiles.sh` to point to your dotfiles repository
   - Modify the `STOW_DIRS` array to match your dotfiles structure

4. **Adjust Script Order**
   - Edit the `SCRIPTS` array in `main.sh` to change execution order

## 📁 Required Dotfiles Structure

For the dotfiles management to work correctly, your dotfiles repository should follow this structure:
```
dotfiles/
├── nvim/
│   └── .config/
│       └── nvim/
│           └── init.vim
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

1. **Scripts Not Found**
   - Ensure you're running `main.sh` from the bootstrap directory
   - Verify all scripts are executable
   - Check that the directory structure matches the expected layout

2. **Stow Conflicts**
   - Existing configurations will be automatically backed up
   - Check the backup directory if you need to restore previous configs

3. **Permission Issues**
   - Ensure you have sudo privileges
   - Check that all scripts are executable
   - Run `chmod +x main.sh scripts/*.sh` if needed

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