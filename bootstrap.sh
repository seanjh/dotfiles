#!/usr/bin/env bash

GIT_REF=main
GITHUB_REPO=seanjh/dotfiles
NIX_FILENAME=shell.nix
NIX_BOOTSTRAP_PATH="$HOME/temp.nix"
NIX_SHELL_URL="https://raw.githubusercontent.com/${GITHUB_REPO}/${GIT_REF}/${NIX_FILENAME}"

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

configure_autoload_nix_shell() {
	local current_shell=$(getent passwd $USER | cut -d: -f7)
	local shell_rc
	local shell_name

	if [[ "$current_shell" == *"/bash"* ]]; then
		shell_rc="$HOME/.bashrc"
		shell_name="bash"
	elif [[ "$current_shell" == *"/zsh"* ]]; then
		shell_rc="$HOME/.zshrc"
		shell_name="zsh"
	else
		echo "Unsupported shell."
		exit 1
	fi

	local snippet="# Automatically enter Nix shell
	if [ -z \"\$IN_NIX_SHELL\" ]; then
		    nix-shell $NIX_SHELL_PATH --run \"exec $current_shell\"
	fi"

	if ! grep -q "Automatically enter Nix shell" "$shell_rc"; then
		echo "$snippet" >> "$shell_rc"
		echo "Snippet added to your $shell_rc."
	else
		echo "Snippet already exists in $shell_rc."
	fi
}

check_nix_installed
initialize_with_nix
configure_autoload_nix_shell

rm -f "$NIX_BOOTSTRAP_PATH"
