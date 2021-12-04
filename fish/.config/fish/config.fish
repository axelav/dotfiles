if status is-interactive
  # Commands to run in interactive sessions can go here
end

set -U fish_greeting ''
set -x EDITOR /usr/local/bin/nvim
set -x PATH /opt/homebrew/bin /opt/homebrew/opt/coreutils/libexec/gnubin /opt/homebrew/opt/findutils/libexec/gnubin $PATH
set -x MANPAGER less -X
# set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
# set -x FZF_CTRL_T_COMMAND '$FZF_DEFAULT_COMMAND'
# https://github.com/webpack/webpack/issues/14532#issuecomment-947012063
set -x NODE_OPTIONS '--openssl-legacy-provider'

fundle plugin 'danhper/fish-ssh-agent'
fundle plugin 'paradox460/paradox-theme'
fundle plugin 'jethrokuan/z'
fundle plugin 'FabioAntunes/fish-nvm'
fundle plugin 'edc/bass'
fundle init

set -x _git_log_oneline_format "%C(bold yellow)%h%C(reset) %s%C(auto)%d%C(reset)"
set -x _git_log_fuller_format "%C(bold yellow)commit %H%C(auto)%d%n%C(bold)Author: %C(blue)%an <%ae> %C(reset)%C(cyan)%ai (%ar)%n%C(bold)Commit: %C(blue)%cn <%ce> %C(reset)%C(cyan)%ci (%cr)%C(reset)%n%+B"

# source $HOME/.config/fish/private.fish
source $HOME/.config/fish/aliases.fish
