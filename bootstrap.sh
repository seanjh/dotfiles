#!/usr/bin/env bash

GIT_REF=main
GITHUB_REPO=seanjh/dotfiles
NIX_FILENAME=shell.nix
NIX_BOOTSTRAP_PATH="$HOME/temp.nix"
NIX_SHELL_URL="https://raw.githubusercontent.com/${GITHUB_REPO}/${GIT_REF}/${NIX_FILENAME}"
NIXPKGS_VERSION='23.11'

CURRENT_SHELL="$(getent passwd $USER | cut -d: -f7)"
SHELL_RC=
SHELL_NAME=

check_nix_install() {
  if ! command -v nix-shell >/dev/null 2>&1; then
    echo "Intalling Nix..."
    curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  fi
}

check_home_manager_install() {
  if ! command -v home-manager >/deb/null 2>&1; then
    echo "Installing Home Manager..."
    nix-channel --add "https://github.com/nix-community/home-manager/archive/release-${NIXPKGS_VERSION}.tar.gz" home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install

    echo "Activating Home Manager configuration..."
    home-manager switch
  fi
}

check_nix_install
check_home_manager_install
