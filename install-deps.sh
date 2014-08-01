#!/usr/bin/env bash

# install command line tools
xcode-select --install

# homebrew!
ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)

# install homebrew packages
./.brew

# install global node modules
./.node-modules

# https://github.com/rupa/z
mkdir -p ~/code/z
curl https://raw.github.com/rupa/z/master/z.sh > ~/code/z/z.sh
chmod +x ~/code/z/z.sh
