#!/bin/bash

# Set zsh as the default shell
if [ "$SHELL" != "/bin/zsh" ]; then
  print_color "Setting zsh as the default shell..." "$YELLOW"
  chsh -s /bin/zsh
fi

# Append custom content to .zshrc-personal
print_color "Appending Go PATH to .zshrc..." "$YELLOW"
ZSHRC="$HOME/.zshrc-personal"
CUSTOM_CONTENT="
# Go PATH configuration added by bootstrap script
export PATH=\"\$PATH:\$(go env GOBIN):\$(go env GOPATH)/bin\"

# NVM configuration added by bootstrap script
export NVM_DIR=\"\$HOME/.nvm\"
[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"  # This loads nvm
[ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\"  # This loads nvm bash_completion
"

print_color "Checking for .zshrc-personal in HOME..." "$YELLOW"
[[ -f ~/.zshrc-personal ]] && . ~/.zshrc-personal

if ! grep -q "Go PATH configuration added by bootstrap script" "$ZSHRC"; then
  echo "$CUSTOM_CONTENT" >> "$ZSHRC"
  print_color "Go PATH configuration added to .zshrc" "$GREEN"
else
  print_color "Go PATH configuration already exists in .zshrc-personal. Skipping..." "$YELLOW"
fi