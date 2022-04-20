#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

ACK_TARGET="$HOME/.ackrc"
GIT_TARGET="$HOME/.gitconfig"
GIT_IGNORE_TARGET="$HOME/.gitignore_global"
GIT_CONFIG_MACOS_TARGET="$HOME/.gitconfig-macos"
GIT_CONFIG_LINUX_TARGET="$HOME/.gitconfig-linux"
GIT_CONFIG_WINDOWS_TARGET="$HOME/.gitconfig-windows"
TMUX_TARGET="$HOME/.tmux.conf"
VIM_TARGET="$HOME/.vim"
DIRENV_TARGET="$HOME/.config/direnv/direnvrc"
INPUTRC_TARGET="$HOME/.inputrc"

ln -sf "$SCRIPT_DIR/ackrc" "$ACK_TARGET" && echo "installed $ACK_TARGET" || echo ackrc error
ln -sf "$SCRIPT_DIR/gitconfig" "$GIT_TARGET" && echo "installed $GIT_TARGET" || echo gitconfig error
ln -sf "$SCRIPT_DIR/gitignore_global" "$GIT_IGNORE_TARGET" && echo "installed $GIT_IGNORE_TARGET" || echo gitignore_global error
ln -sf "$SCRIPT_DIR/gitconfig-macos" "$GIT_CONFIG_MACOS_TARGET" && echo "installed $GIT_CONFIG_MACOS_TARGET" || echo gitconfig-macos error
ln -sf "$SCRIPT_DIR/gitconfig-linux" "$GIT_CONFIG_LINUX_TARGET" && echo "installed $GIT_CONFIG_LINUX_TARGET" || echo gitconfig-linux error
ln -sf "$SCRIPT_DIR/gitconfig-windows" "$GIT_CONFIG_WINDOWS_TARGET" && echo "installed $GIT_CONFIG_WINDOWS_TARGET" || echo gitconfig-windows error
ln -sf "$SCRIPT_DIR/tmux.conf" "$TMUX_TARGET" && echo "installed $TMUX_TARGET" || echo tmux.conf error
ln -sf "$SCRIPT_DIR/vim" "$VIM_TARGET" && echo "installed $VIM_TARGET" || echo vim/ error
ln -sf "$SCRIPT_DIR/inputrc" "$INPUTRC_TARGET" && echo "installed $INPUTRC_TARGET" || echo .inputrc error
vim -c 'PlugInstall' -c 'qa!'
mkdir -p "$HOME/.config/direnv" && ln -sf "$SCRIPT_DIR/direnv.sh" "$DIRENV_TARGET" && echo "installed $DIRENV_TARGET" || echo direnvrc error
