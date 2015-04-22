#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")";
git pull origin master;

function doIt() {
  rsync --exclude ".git/" --exclude "iterm/" --exclude ".DS_Store" \
    --exclude "gnupg/" --exclude "scripts/" --exclude "tmux/" \
    --exclude "bootstrap.sh" --exclude "README.md" --exclude "install-deps.sh" \
    --exclude ".npm-install" --exclude ".brew" --exclude ".cask" \
    --exclude "TODO.md" --exclude ".tmux.conf" --exclude ".osx" -av . ~;
  source ~/.bash_profile;
}

doIt;
unset doIt;
exit 0;
