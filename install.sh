#!/bin/zsh

cd "$(dirname "${(%):-%N}")";

# command line tools
xcode-select --install

# homebrew, packages & casks
./.brew
./.cask

# set zsh as default shell
chsh -s $(which zsh)

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

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
