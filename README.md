# Arch Linux Dotfiles Bootstrap Script

This repository contains a module bootstrap system for setting up a new Arch Linux installation with my preferred configurations and tools. The script architecture is divided into individual components for better maintainability and flexibility.

## ⚠️ Important Security Notice

Before running this or any bootstrap script, you should:

1. **Read and understand the scripts**: Take time to review all scripts in the `scripts/` directory to understand what changes they will make to your system
2. **Verify the source**: Ensure you trust the source of all scripts
3. **Audit the packages**: Review the list of packasges that will be installed in `core_packages.sh` and `aur_setup.sh`
4. **Backup your data**: While these scripts shouldn't affect existing data, it's always good practice to backup before major system changes

## 🗂️ Directory Structure

```
dotfiles/
├── bootstrap.sh           # Main orchestration script
└── scripts/
  └── utils.sh           # Utility functions and common variables
```

## 🔍 What Each Script Does

### bootstrap.sh
- Orchestrates the execution of all other scripts
- Maintains execution order
- Provides timing information
- Handles errors and script validation

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

2. ** Make Scripts Executable**

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
- Consider creating a backup or snapshot of your system before running any scripts