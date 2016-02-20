#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# command line tools
xcode-select --install

# homebrew, packages & casks
./.brew
./.cask

# set brew'd bash as default shell
sudo echo $(brew --prefix)/bin/bash >> /etc/shells && \
chsh -s $(brew --prefix)/bin/bash

# dotfiles
./bootstrap.sh

# clone vim-vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# nvm & node
nvm install stable
nvm alias default stable
nvm use default

# global node modules
./.npm
