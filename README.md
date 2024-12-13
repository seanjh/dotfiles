# Requirements

- `git`
- `bash`

# Setup

- Clone dotfiles - `git clone git@github.com:seanjh/dotfiles.git ~/.config/dotfiles`
- Clone neovim config - `git clone git@github.com:seanjh/nvim.git ~/.config/nvim`
- Install nix - ([Getting started with Determinate](https://docs.determinate.systems/getting-started))
- Install home-manager - `nix run home-manager/release-24.11 -- init`
- Activate home-manager - `home-manager switch --flake ~/.config/dotfiles/home-manager#HOSTNAME`
