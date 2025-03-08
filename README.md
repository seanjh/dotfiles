# Requirements

- `git`
- `bash`
- `curl`

# Setup

- Clone dotfiles - `git clone https://github.com/seanjh/dotfiles.git ~/.config/dotfiles`
- Clone neovim config - `git clone https://github.com/seanjh/nvim.git ~/.config/nvim`
- Install nix - ([Getting started with Determinate](https://docs.determinate.systems/getting-started))
- Run home-manager - `nix run nixpkgs#home-manager -- switch --flake ~/.config/dotfiles/home-manager#HOSTNAME`
