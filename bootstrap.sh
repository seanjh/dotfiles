#!/usr/bin/env bash

GIT_REF="${1:-main}"
DOTFILES_DIR="$HOME/.env/dotfiles"
NIXPKGS_VERSION='24.05'
DETERMINATE_INSTALLER_VERSION='0.24.0'
DEFAULT_SHELL=$(basename "$SHELL")

SHELL_PROFILE=
if [ "$DEFAULT_SHELL" = "bash" ]; then
  SHELL_PROFILE="$HOME/.profile"
elif [ "$DEFAULT_SHELL" = "zsh" ]; then
  SHELL_PROFILE="$HOME/.zprofile"
else
  echo "Unsupported shell: $DEFAULT_SHELL"
  exit 1
fi

DOTFILES_DIR="$HOME/.env/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles repository..."
  mkdir -p "$HOME/.env"
  git clone -b "$GIT_REF" --single-branch https://github.com/seanjh/dotfiles "$DOTFILES_DIR"
fi

if ! command -v nix-shell >/dev/null 2>&1; then
  echo "Intalling Nix..."
  curl --proto '=https' --tlsv1.2 -sSf -L "https://github.com/DeterminateSystems/nix-installer/releases/download/v$DETERMINATE_INSTALLER_VERSION/nix-installer.sh" | sh -s -- install
fi

if ! command -v home-manager >/dev/null 2>&1; then
  echo "Installing Home Manager..."
  nix run "home-manager/release-$NIXPKGS_VERSION" -- init --switch
fi

ln -sf "$DOTFILES_DIR/home.nix" "$HOME/.config/home-manager/home.nix"

echo "Setup complete. Please restart your shell."
