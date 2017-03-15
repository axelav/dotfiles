export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="philips"
ENABLE_CORRECTION="true"

plugins=(git gpg-agent pass z npm history zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

for file in ~/.{extra,exports,aliases,functions}; do
  [ -r "$file" ] && source "$file"
done
unset file

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"

source ~/.npm_completion

source $ZSH/oh-my-zsh.sh

unsetopt correct_all
