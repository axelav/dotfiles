#!/usr/bin/env bash

# install command line tools
xcode-select --install

# homebrew!
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install homebrew packages
./.brew

# install current stable version of node
nvm install stable

# install global node modules
./.node-modules

