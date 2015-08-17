#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# install command line tools
xcode-select --install

# install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install homebrew packages & application casks
./.brew
./.cask

# install dotfiles
./bootstrap.sh

# set up vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# NOTE: build command-t
cd ~/.vim/bundle/command-t/ruby/command-t/
ruby extconf.rb
make

cd "$(dirname "${BASH_SOURCE}")";

# install current stable version of node & iojs
nvm install stable
nvm install iojs
nvm alias default iojs
nvm use default

# install global node modules
./.npm

