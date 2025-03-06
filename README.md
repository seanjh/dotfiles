# Requirements

- `git`
- `bash`
- `curl`

# Setup

- Clone dotfiles - `git clone https://github.com/seanjh/dotfiles.git ~/.config/dotfiles`
- Clone neovim config - `git clone https://github.com/seanjh/nvim.git ~/.config/nvim`
- Install nix - ([Getting started with Determinate](https://docs.determinate.systems/getting-started))
- Install home-manager - `nix profile install home-manager/release-24.11`
- Activate home-manager - `home-manager switch --flake ~/.config/dotfiles/home-manager#HOSTNAME`
