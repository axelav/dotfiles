if status is-interactive
  # Commands to run in interactive sessions can go here
end

set -U fish_greeting ""
set -x EDITOR /usr/local/bin/nvim
set -x PATH /usr/local/bin /usr/local/opt/coreutils/libexec/gnubin /usr/local/opt/findutils/libexec/gnubin /usr/local/opt/gnu-sed/libexec/gnubin /bin /usr/bin /usr/sbin /sbin /usr/local/sbin $HOME/bin $PATH
set -x MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
set -x MANPAGER less -X
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# fundle plugin 'danhper/fish-fastdir'
# fundle plugin 'edc/bass'
# fundle plugin 'arzig/nvm-fish'
fundle plugin 'danhper/fish-ssh-agent'
fundle plugin 'paradox460/paradox-theme'

fundle init



set -x _git_log_oneline_format "%C(bold yellow)%h%C(reset) %s%C(auto)%d%C(reset)"
set -x _git_log_fuller_format "%C(bold yellow)commit %H%C(auto)%d%n%C(bold)Author: %C(blue)%an <%ae> %C(reset)%C(cyan)%ai (%ar)%n%C(bold)Commit: %C(blue)%cn <%ce> %C(reset)%C(cyan)%ci (%cr)%C(reset)%n%+B"

# source $HOME/.config/fish/private.fish
source $HOME/.config/fish/aliases.fish
