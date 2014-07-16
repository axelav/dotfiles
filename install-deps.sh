#!/usr/bin/env bash

# install command line tools
xcode-select --install

# homebrew!
ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)

# install homebrew packages
./.brew

# install npm globals
npm i -g browserify
npm i -g coffee-script-redux
npm i -g express
npm i -g grunt-cli
npm i -g gulp
npm i -g jshint
npm i -g lute
npm i -g rainbowify
npm i -g spotify-cli
npm i -g trash
npm i -g forecast

# https://github.com/rupa/z
mkdir -p ~/code/z
curl https://raw.github.com/rupa/z/master/z.sh > ~/code/z/z.sh
chmod +x ~/code/z/z.sh
