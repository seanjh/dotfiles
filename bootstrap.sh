#!/bin/bash

# Function to detect the shell and update the respective config file
update_shell_config() {
  local config_file="$1"
  local snippet_marker="# Load custom Nix environment"

  echo "Modifying $config_file to load shell.nix on startup..."
  if grep -q "$snippet_marker" "$config_file"; then
    echo "Configuration snippet already present in $config_file"
    return
  fi

  cat <<EOF >> "$config_file"
# Load custom Nix environment
if [ -f "\$HOME/.env/dotfiles/shell.nix" ]; then
  source "\$(nix-build --no-out-link "\$HOME/.env/dotfiles/shell.nix")/activate"
fi
EOF
}

if ! command -v nix &> /dev/null; then
  echo "Nix is not installed. Installing Nix..."
  sh <(curl -L https://nixos.org/nix/install) --daemon
fi

if ! command -v nix &> /dev/null; then
  echo "Failed to install Nix. Please check the installation logs."
  exit 1
fi

GIT_REF="${1:-main}"

# Clone dotfiles repository
DOTFILES_DIR="$HOME/.env/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning dotfiles repository..."
    git clone -b "$GIT_REF" --single-branch https://github.com/seanjh/dotfiles "$DOTFILES_DIR"
fi

# Detect default shell and update the correct shell configuration file
DEFAULT_SHELL=$(basename "$SHELL")
if [ "$DEFAULT_SHELL" = "bash" ]; then
  update_shell_config "$HOME/.bashrc"
elif [ "$DEFAULT_SHELL" = "zsh" ]; then
  update_shell_config "$HOME/.zshrc"
else
  echo "Unsupported shell: $DEFAULT_SHELL"
  exit 1
fi

echo "Setup complete. Please restart your shell."
