#!/bin/zsh

cd "$(dirname "${(%):-%N}")";

# command line tools
xcode-select --install

# homebrew, packages & casks
./.brew
./.cask

# install base16 shell script
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# set zsh as default shell
chsh -s $(which zsh)

# install oh-my-zsh & plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/lukechilds/zsh-nvm $ZSH_CUSTOM/plugins/zsh-nvm

# dotfiles
./bootstrap.sh

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# symlink vimrc to vim/init
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# nvm & node
nvm install stable

# global node modules
./.npm

# install rust
# https://www.rust-lang.org/en-US/install.html
curl https://sh.rustup.rs -sSf | sh

# create code directory
mkdir $HOME/s

# create screenshots folder
mkdir $HOME/Screenshots

# download Fira Code v1.204 font to Downloads
# https://github.com/tonsky/FiraCode
wget https://github.com/tonsky/FiraCode/releases/download/1.204/FiraCode_1.204.zip -P $HOME/Downloads
