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

# install base16 shell script
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

mkdir $HOME/.tmux

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install zim
# https://github.com/zimfw/zimfw
git clone --recursive https://github.com/zimfw/zimfw.git ${ZDOTDIR:-${HOME}}/.zim

setopt EXTENDED_GLOB
for template_file in ${ZDOTDIR:-${HOME}}/.zim/templates/*; do
  user_file="${ZDOTDIR:-${HOME}}/.${template_file:t}"
  touch ${user_file}
  ( print -rn "$(<${template_file})$(<${user_file})" >! ${user_file} ) 2>/dev/null
done

# set zsh as default shell
chsh -s $(which zsh)

# zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
curl https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/gpg-agent/gpg-agent.plugin.zsh > $HOME/.zsh/gpg-agent.plugin.zsh

# dotfiles
./bootstrap.sh

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# symlink vimrc to vim/init
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# nvm & node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install stable

# global node modules
./node-modules

# install rust
# https://www.rust-lang.org/en-US/install.html
curl https://sh.rustup.rs -sSf | sh

# create code directory
mkdir $HOME/s

# create screenshots folder
mkdir $HOME/Screenshots

# SF Mono install instructions
# http://osxdaily.com/2018/01/07/use-sf-mono-font-mac/
