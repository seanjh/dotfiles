let
  nixpkgs = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    aws-vault
    awscli2
    direnv
    gcc
    gh
    go
    jq
    nodenv
    nodejs_20
    neovim
    podman
    pyenv
    python312
    ripgrep
  ];

  fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" "Inconsolata" "DroidSansMono" ]; })
  ];
	ss

  shellHook = ''
    mkdir -p $HOME/.config/{nvim,direnv}
    cp -f "$HOME/.env/dotfiles/shell.nix" "$HOME/.config/shell.nix"
    ln -sf "$HOME/.env/dotfiles/direnv.sh" "$HOME/.config/direnv/direnvrc"
    ln -sf "$HOME/.env/dotfiles/gitconfig" "$HOME/.gitconfig"
    ln -sf "$HOME/.env/dotfiles/gitignore_global" "$HOME/.gitignore_global"
    ln -sf "$HOME/.env/dotfiles/gitconfig-linux" "$HOME/.gitignore-linux"
    ln -sf "$HOME/.env/dotfiles/inputrc" "$HOME/.inputrc"
    ln -sf "$HOME/.env/dotfiles/nvim/init.lua" "$HOME/.config/nvim/init.lua"
    ln -sf "$HOME/.env/dotfiles/nvim/lua/" "$HOME/.config/nvim"
    ln -sf "$HOME/.env/dotfiles/tmux.conf" "$HOME/.tmux.conf"
  '';
}
