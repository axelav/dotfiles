export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="crunch"
ENABLE_CORRECTION="true"

export NVM_LAZY_LOAD=true

plugins=(git gpg-agent pass z npm history zsh-nvm zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

source ~/.npm_completion

source $ZSH/oh-my-zsh.sh

for file in ~/.{exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

# https://github.com/zsh-users/zsh-autosuggestions#disabling-suggestion-for-large-buffers
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

setopt nobanghist
unsetopt correct_all

# source rust
source $HOME/.cargo/env

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
