#!/usr/bin/env zsh

cd "$(dirname "${(%):-%N}")";

# command line tools
xcode-select --install

# homebrew
./brew

# install fzf keybindings
/opt/homebrew/opt/fzf/install

# create necessary directories
mkdir $HOME/.config
mkdir $HOME/.tmux
# create code directory
mkdir -p $HOME/s
# create screenshots directory
mkdir $HOME/Screenshots

# install tmux plugin manager
# TODO need to 'prefix + I' to install plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# dotfiles
stow \
  alacritty \
  git \
  gpg \
  mutt \
  nodejs \
  nvim \
  rsync \
  tmux \
  zsh \
  --verbose

# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Save screenshots to the ~/Screenshots directory
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

# install fonts
# https://github.com/IBM/plex
# https://developer.apple.com/fonts/

# coc-vim
# CocInstall coc-tsserver coc-json coc-html coc-css coc-eslint coc-prettier

# disable apple warning about apps from unapproved developers
# sudo spctl --master-disable
