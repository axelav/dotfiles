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

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# nvm & node
nvm install stable
nvm alias default stable
nvm use default

# global node modules
./.npm
