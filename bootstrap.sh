#!/bin/zsh

cd "$(dirname "${(%):-%N}")";
git pull origin master;

function doIt() {
  rsync \
    --exclude ".DS_Store" \
    --exclude ".brew" \
    --exclude ".cask" \
    --exclude ".git/" \
    --exclude ".npm" \
    --exclude ".osx" \
    --exclude "README.md" \
    --exclude "Session.vim" \
    --exclude "bootstrap.sh" \
    --exclude "com.googlecode.iterm2.plist" \
    --exclude "install.sh" \
    -av . ~;
  source ~/.zshrc;
}

doIt;
unset doIt;
exit 0;
