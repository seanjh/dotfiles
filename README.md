# Requirements

- `git`
- `bash`
- `curl`

# Setup

- Clone dotfiles - `git clone https://github.com/seanjh/dotfiles.git ~/.config/dotfiles`
- Clone neovim config - `git clone https://github.com/seanjh/nvim.git ~/.config/nvim`
- Install nix - ([Getting started with Determinate](https://docs.determinate.systems/getting-started))
- Install home-manager from flake in standalone mode - `nix run home-manager/release-25.11 -- switch --flake ~/.config/dotfiles/home-manager#SOME-HOST`
