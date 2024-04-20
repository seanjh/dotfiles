#!/usr/bin/env bash

GIT_REF=
GITHUB_REPO=seanjh/dotfiles
NIX_FILENAME=shell.nix
NIX_BOOTSTRAP_PATH="$HOME/temp.nix"
NIX_SHELL_URL="https://raw.githubusercontent.com/${GITHUB_REPO}/${GIT_REF}/${NIX_FILENAME}"

CURRENT_SHELL="$(getent passwd $USER | cut -d: -f7)"
SHELL_RC=
SHELL_NAME=

if [[ -z "$1" ]]; then
  GIT_REF="$1"
else
  GIT_REF='main'
fi

check_nix_install() {
  if ! command -v nix-shell >/dev/null 2>&1; then
    echo "Intalling Nix..."
    curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  fi
}

initialize_with_nix() {
  if [ ! -f "$NIX_BOOTSTRAP_PATH" ]; then
    echo "Downloading Nix bootstrap configuration..."
    curl -L -o "$NIX_BOOTSTRAP_PATH" "$NIX_SHELL_URL"
    nix-shell "$NIX_BOOTSTRAP_PATH"
  fi
}

configure_autoload() {
  if [[ "$CURRENT_SHELL" == *"/bash"* ]]; then
    $SHELL_RC="$HOME/.bashrc"
    $SHELL_NAME="bash"
  elif [[ "$CURRENT_SHELL" == *"/zsh"* ]]; then
    $SHELL_RC="$HOME/.zshrc"
    $SHELL_NAME="zsh"
  else
    echo "Unsupported shell."
    exit 1
  fi

  local snippet="# Automatically enter Nix shell
  if [ -z \"\$IN_NIX_SHELL\" ]; then
        nix-shell $NIX_SHELL_PATH --run \"exec $CURRENT_SHELL\"
  fi"

  if ! grep -q "Automatically enter Nix shell" "$SHELL_RC"; then
    echo "$snippet" >> "$SHELL_RC"
    echo "Snippet added to your $SHELL_RC."
  else
    echo "Snippet already exists in $SHELL_RC."
  fi
}

finish() {
  exit # drop out of the initial nix-shell
  . "$SHELL_RC"
}

check_nix_install
initialize_with_nix
configure_autoload
finish
