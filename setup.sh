#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

ACK_TARGET="$HOME/.ackrc"
GIT_TARGET="$HOME/.gitconfig"
GIT_IGNORE_TARGET="$HOME/.gitignore_global"
TMUX_TARGET="$HOME/.tmux.conf"
VIM_TARGET="$HOME/.vim"
DIRENV_TARGET="$HOME/.config/direnv/direnvrc"

ln -s "$SCRIPT_DIR/ackrc" "$ACK_TARGET" && echo "installed $ACK_TARGET" || echo skipping ackrc
ln -s "$SCRIPT_DIR/gitconfig" "$GIT_TARGET" && echo "installed $GIT_TARGET" || echo skipping gitconfig
ln -s "$SCRIPT_DIR/gitignore_global" "$GIT_IGNORE_TARGET" && echo "installed $GIT_IGNORE_TARGET" || echo skipping gitignore_global
ln -s "$SCRIPT_DIR/tmux.conf" "$TMUX_TARGET" && echo "installed $TMUX_TARGET" || echo skipping tmux.conf
ln -s "$SCRIPT_DIR/vim" "$VIM_TARGET" && echo "installed $VIM_TARGET" || echo skipping vim/
[ ! -d "$HOME/.vim/bundle/Vundle.vim" ] && echo cloning Vundle && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim || echo skipping Vundle
mkdir -p "$HOME/.config/direnv/direnvrc"
