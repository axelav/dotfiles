#!/bin/zsh

cd "$(dirname "${(%):-%N}")";

# command line tools
xcode-select --install

# homebrew, packages & casks
./.brew
./.cask

# set zsh as default shell
chsh -s $(which zsh)

# install oh-my-zsh & plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# dotfiles
./bootstrap.sh

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# nvm & node
nvm install stable
nvm alias default stable
nvm use default

# global node modules
./.npm
