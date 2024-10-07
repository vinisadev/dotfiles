# dotfiles

My personal Arch Linux configurations. These will not work unless you are on Arch Linux.

To set your system up using these dotfiles, run the following command:

#### **BE SURE TO AUDIT THE SCRIPT BEFORE RUNNING. NEVER RUN UNKNOWN SCRIPTS ON YOUR COMPUTER**

```sh
curl -o- https://raw.githubusercontent.com/vinisadev/dotfiles/main/bootstrap.sh | bash
```

## How the Script Works

The script follows a very strict path in setting up the system, getting it ready to rock and roll. It follows the steps below:

1. Checks to see if you are on Arch Linux
2. Runs all system updates
3. Installs Git
4. Sets the default git branch to `master`
5. Clones this repository
6. Installs essential packages from the Arch Linux Core Repository
7. Installs the Rust Stable Toolchain
8. Configures Docker for the user
9. Uses GNU Stoe to symlink all dotfiles
10. Appends some basic config to `.zshrc`
11. Installs the Paru AUR helper
12. Installs AUR packages
13. Installs NVM and the latest version of Node.js
14. Sets your default Shell to zsh if not already the case

## Packages Installed with this Script

### Arch Linux Core Repository

- [ ] DBeaver
- [ ] Discord
- [ ] Docker
- [ ] Docker Compose
- [ ] Flameshot
- [ ] Gnome Disk Utility
- [ ] Go
- [ ] Godot
- [ ] LazyGit
- [ ] LibreOffice Still
- [ ] Neovim
- [ ] Rustup
- [ ] Steam
- [ ] GNU Stow

### Dotfiles

- [ ] nvim
- [ ] qtile

### AUR Packages

- [ ] Google Chrome
- [ ] Insomnia
- [ ] Railway CLI
- [ ] Slack Desktop
- [ ] Visual Studio Code

### Bash Script Based

- [ ] NVM
