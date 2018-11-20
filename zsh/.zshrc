# Change default zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

for file in ~/.{exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/gpg-agent.plugin.zsh

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20 # https://github.com/zsh-users/zsh-autosuggestions#disabling-suggestion-for-large-buffers

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use

setopt nobanghist
unsetopt correct_all

# source rust
source $HOME/.cargo/env

# use vi bindings - must be set before fzf is sourced
bindkey -v

# bind <ctrl + space> to accept the current autosuggestion
bindkey '^ ' autosuggest-accept

# source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source z
. /usr/local/etc/profile.d/z.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc';
fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc';
fi

eval "$(pyenv init -)"

# lazy nvm
# http://broken-by.me/lazy-load-nvm/
# lazynvm() {
#   unset -f nvm node npm
#   export NVM_DIR=~/.nvm
#   [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# }

# nvm() {
#   lazynvm
#   nvm $@
# }

# node() {
#   lazynvm
#   node $@
# }

# npm() {
#   lazynvm
#   npm $@
# }

# declare -a NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

# NODE_GLOBALS+=("node")
# NODE_GLOBALS+=("nvm")

# load_nvm () {
#   export NVM_DIR=~/.nvm
#   [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# }

# for cmd in "${NODE_GLOBALS[@]}"; do
#   eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
# done
