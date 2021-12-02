#!/usr/bin/env zsh

cd "$(dirname "${(%):-%N}")";

# command line tools
xcode-select --install

# homebrew, packages & casks
./brew
./cask

# install fzf keybindings
/usr/local/opt/fzf/install

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
  git \
  gpg \
  mutt \
  nodejs \
  rsync \
  tmux \
  vim \
  zsh \
  --verbose

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# symlink vimrc to vim/init
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# nvm & node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install --lts
# nvm install stable

# global node modules
./install_node_modules

# create code directories
mkdir -p $HOME/Documents/s/{axelav,pillar}

# create screenshots folder
mkdir $HOME/Screenshots

# install Apple fonts
# https://developer.apple.com/fonts/
