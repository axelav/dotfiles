#!/usr/bin/env zsh

cd "$(dirname "${(%):-%N}")";

# command line tools
xcode-select --install

# homebrew
which -s brew
if [[ $? != 0 ]] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # TODO run these two lines to make `brew` available in path
  # echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/axelav/.profile
  # eval "$(/opt/homebrew/bin/brew shellenv)"
else
  brew update
  brew upgrade
fi

brew bundle install --file ./Brewfile

# install fzf keybindings
/opt/homebrew/opt/fzf/install

# create necessary directories
mkdir $HOME/.config
mkdir $HOME/.tmux
# create code directory
mkdir -p $HOME/s
# create screenshots directory
# mkdir $HOME/Screenshots

# install tmux plugin manager
# TODO need to 'prefix + I' to install plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install lunarvim
LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

# dotfiles
stow \
  alacritty \
  git \
  gpg \
  lunarvim \
  mutt \
  nodejs \
  rsync \
  tmux \
  zsh \
  --verbose

# install volta
curl https://get.volta.sh | bash

# Save screenshots to the ~/Screenshots directory
defaults write com.apple.screencapture location -string "$HOME/Documents/Screenshots"

# install fonts
# https://github.com/IBM/plex
# https://developer.apple.com/fonts/

# disable apple warning about apps from unapproved developers
# sudo spctl --master-disable
