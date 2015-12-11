# load ~/.extra, ~/.exports, ~/.aliases, and ~/.functions
# ~/.extra can be used for settings you don't want to commit
for file in ~/.{extra,exports,aliases,functions}; do
  [ -r "$file" ] && source "$file"
done
unset file

if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
  GIT_PROMPT_THEME=Default
  source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
fi

# init z - https://github.com/rupa/z
. `brew --prefix`/etc/profile.d/z.sh

# case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# append to the bash history file, rather than overwriting it
shopt -s histappend

# autocorrect typos in path names when using `cd`
shopt -s cdspell

# enable some bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null
done

# add tab completion for ssh hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh mosh sshfs

# add tab completion for `defaults read|write NSGlobalDomain`
# you could just use `-g` instead, but i like being explicit
complete -W "NSGlobalDomain" defaults

# add `killall` tab completion for common apps
complete -o "nospace" -W "Finder Dock Mail Safari iTunes iCal Address\ Book SystemUIServer" killall

# if possible, add tab completion for many more commands
# [ -f /etc/bash_completion ] && source /etc/bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# git completition
source ~/.git_completion

# npm tab completions
source ~/.npm_completion

# export & source nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# load autoenv
source /usr/local/opt/autoenv/activate.sh

# NOTE: need to build vim with system ruby for command-t to work correctly; uncomment if needed
# load rvm into a shell session *as a function*
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Invoke GnuPG-Agent the first time we login.
# http://unix.stackexchange.com/questions/46960/how-to-configure-gpg-to-enter-passphrase-only-once-per-session
# Does `~/.gpg-agent-info' exist and points to gpg-agent process accepting signals?
if test -f $HOME/.gpg-agent-info && \
    kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null; then
    GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info | cut -c 16-`
else
    # No, gpg-agent not available; start gpg-agent
    eval `gpg-agent --daemon --no-grab --write-env-file $HOME/.gpg-agent-info`
fi
export GPG_TTY=`tty`
export GPG_AGENT_INFO

# base16 shell
BASE16_SHELL="$HOME/.config/base16-tomorrow.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
