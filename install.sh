#!/usr/bin/env zsh

cd "$(dirname "${(%):-%N}")";

# command line tools
xcode-select --install

# homebrew, packages & casks
./brew
./cask

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
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

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

# create code directories
mkdir -p $HOME/Documents/s/{axelav,pillar}

# create screenshots folder
mkdir $HOME/Screenshots

# install fonts
# https://github.com/IBM/plex
# https://developer.apple.com/fonts/
