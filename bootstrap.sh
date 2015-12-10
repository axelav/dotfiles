#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")";
git pull origin master;

function doIt() {
  rsync --exclude ".git/" --exclude "iterm/" --exclude ".DS_Store" \
    --exclude "gnupg/" --exclude "scripts/" \
    --exclude "bootstrap.sh" --exclude "README.md" --exclude "install.sh" \
    --exclude ".npm" --exclude ".brew" --exclude ".cask" --exclude ".osx" \
    --exclude "assets" -av . ~;
  cp assets/base16-tomorrow.dark.sh "$HOME/.config/base16-shell/base16-tomorrow.dark.sh";
  source ~/.bash_profile;
}

doIt;
unset doIt;
exit 0;
