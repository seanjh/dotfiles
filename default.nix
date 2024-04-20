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
    function safeLink() {
      local target=$1
      local linkName=$2
      if [ ! -e "$linkName" ]; then
        ln -s "$target" "$linkName"
        echo "Linked $linkName -> $target"
      elif [ "$(readlink "$linkName")" != "$target" ]; then
        echo "Updating link $linkName -> $target"
        ln -sf "$target" "$linkName"
      else
        echo "Link already set correctly: $linkName -> $target"
      fi
    }

    mkdir -p $HOME/.config/{nvim,direnv}
    safeLink "${dotfiles}/direnv.sh" "$HOME/.config/direnv/direnvrc"
    safeLink "${dotfiles}/gitconfig" "$HOME/.gitconfig"
    safeLink "${dotfiles}/gitignore_global" "$HOME/.gitignore_global"
    safeLink "${dotfiles}/gitconfig-linux" "$HOME/.gitignore-linux"
    safeLink "${dotfiles}/inputrc" "$HOME/.inputrc"
    safeLink "${dotfiles}/nvim/init.lua" "$HOME/.config/nvim/init.lua"
    safeLink "${dotfiles}/nvim/lua/" "$HOME/.config/nvim/lua"
    safeLink "${dotfiles}/tmux.conf" "$HOME/.tmux.conf"
  '';
}
