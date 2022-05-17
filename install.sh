#!/usr/bin/env zsh

cd "$(dirname "${(%):-%N}")";

# command line tools
xcode-select --install

# homebrew
./brew

# install fzf keybindings
/opt/homebrew/opt/fzf/install

mkdir $HOME/.config
mkdir $HOME/.tmux

# install tmux plugin manager
# TODO need to 'prefix + I' to install plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install zim
# https://github.com/zimfw/zimfw
# TODO how do I get the templates installed? actually I think running this curl thing does it automatically
# curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

# dotfiles
stow \
  alacritty \
  fish \
  git \
  gpg \
  mutt \
  nodejs \
  nvim \
  rsync \
  tmux \
  --verbose

# install fundle
# https://github.com/danhper/fundle
curl -sfL https://git.io/fundle-install | fish

# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# create code directory
mkdir -p $HOME/s

# create screenshots directory
mkdir $HOME/Screenshots

# Save screenshots to the ~/Screenshots directory
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

# install fonts
# https://github.com/IBM/plex
# https://developer.apple.com/fonts/

# coc-vim
# CocInstall coc-tsserver coc-json coc-html coc-css coc-eslint coc-prettier´

# disable apple warning about apps from unapproved developers
# sudo spctl --master-disable
