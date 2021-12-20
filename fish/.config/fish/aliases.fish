# lsd
alias ls='lsd --group-dirs first'
alias l='ls -A'
alias ll='ls -l'
alias la='ls -lA'
alias lt='ls --tree'

# utilities
alias du="du -h -d 1"
alias fs="stat -c \"%s bytes\""
alias h="history"
alias j="jobs -l"
alias m="mutt"
alias mv="mv -iv"
alias o="open"
alias oo="open ."
alias ps="ps -ax"
alias rm="rm -v"
alias s="cd ~/s"
alias t="touch"
alias timestamp="date +%Y%m%d%H%M%S"
alias datestamp="date +%Y%m%d"

# git
alias gRa='git remote add'
alias gRl='git remote --verbose'
alias gb='git branch'
alias gbc='git checkout -b'
alias gbd='git branch -D'
alias gbl='git branch -vv'
alias gbm='git branch -m'
alias gc='git commit --verbose'
alias gcF='git commit --verbose --amend'
alias gcf='git commit --amend --reuse-message HEAD'
alias gcm='git commit --message'
alias gco='git checkout'
alias gcs='git show --pretty=format:"$_git_log_fuller_format"'
alias gfc='git clone'
alias gfu='git fetch --all --prune && git merge --ff-only @\{u\}'
alias giA='git add -p'
alias giD='git diff --no-ext-diff --cached --word-diff'
alias gia='git add'
alias gid='git diff --no-ext-diff --cached'
alias gii='git add --intent-to-add'
alias gir='git reset'
alias gl='git log --topo-order --pretty=format:"$_git_log_fuller_format"'
alias gla='git log --graph --all --pretty=format:"$_git_log_oneline_format"'
alias glo='git log --topo-order --pretty=format:"$_git_log_oneline_format" -n 25'
alias gloc='git ls-files | xargs wc -l'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gs='git stash'
alias gsd='git stash show --patch --stat'
alias gsl='git stash list'
alias gsp='git stash pop'
alias gss='git stash save --include-untracked'
alias gsw='git stash save --include-untracked --keep-index'
alias gsx='git stash drop'
alias gt='git tag'
alias gtx='git tag --delete'
alias gu='git reset --soft HEAD~1' # http://stackoverflow.com/questions/927358/undo-the-last-git-commit
alias gum='git reset --merge HEAD~1'
alias gwD='git diff --no-ext-diff --word-diff'
alias gwd='git diff --no-ext-diff'
alias gwip="git commit --no-verify -am '!! WIP !! [ci skip]'"
alias gws='git status --short'

alias grecap="git for-each-ref --sort='-authordate:iso8601' --format=' %(color:green)%(authordate:relative)%09%(color:white)%(refname:short)' refs/heads"

# enable aliases to be sudo'd
alias sudo='sudo '

# networking
# per support.apple.com, this is the new command: http://support.apple.com/kb/ht5343
alias flush='killall -HUP mDNSResponder' # flush Directory Service cache
alias httpdump='sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\"'
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"
alias localip='ipconfig getifaddr en0'
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"

# recursively delete `.ds_store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# empty the trash on all mounted volumes and the main hdd
# also, clear system logs to improve shell startup speed
alias emptytrash='sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl'

# show/hide hidden files in finder
alias show='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'

# emacs
alias e='emacsclient -t'
alias ec='emacsclient -c'
# alias vim='emacsclient -t'
# alias vi='emacsclient -t'
