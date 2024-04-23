#!/usr/bin/env bash

GIT_REF="${1:-main}"
DOTFILES_DIR="$HOME/.env/dotfiles"
NIXPKGS_VERSION='23.11'
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
  curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

if ! command -v home-manager >/dev/null 2>&1; then
  echo "Installing Home Manager..."
  #nix-channel --add "https://nixos.org/channels/nixos-${NIXPKGS_VERSION}"
  nix-channel --add "https://github.com/nix-community/home-manager/archive/release-${NIXPKGS_VERSION}.tar.gz" home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install

  . "$SHELL_PROFILE"
fi

ln -sf "$DOTFILES_DIR/home.nix" "$HOME/.config/home-manager/home.nix"

echo "Setup complete. Please restart your shell."
