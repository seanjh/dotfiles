let
  nixpkgs = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };

  dotfiles = pkgs.fetchFromGitHub {
    owner = "seanjh";
    repo = "dotfiles";
    rev = "bc3ede877ee88a449600bbe73a4d144e13987346";
    sha256 = "sha256-u3nll+ZP075o+VfLlh/5FurDU+VPeWEpq/XYqP6LNNE=";
  };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    direnv
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

  shellHook = ''
    mkdir -p $HOME/.config/{nvim,direnv}
    ln -sf "${dotfiles}/direnv.sh" "$HOME/.config/direnv/direnvrc"
    ln -sf "${dotfiles}/gitconfig" "$HOME/.gitconfig"
    ln -sf "${dotfiles}/gitignore_global" "$HOME/.gitignore_global"
    ln -sf "${dotfiles}/gitconfig-linux" "$HOME/.gitignore-linux"
    ln -sf "${dotfiles}/inputrc" "$HOME/.inputrc"
    ln -sf "${dotfiles}/nvim/init.lua" "$HOME/.config/nvim/init.lua"
    ln -sf "${dotfiles}/nvim/lua/" "$HOME/.config/nvim/lua"
    ln -sf "${dotfiles}/tmux.conf" "$HOME/.tmux.conf"
  '';
}
