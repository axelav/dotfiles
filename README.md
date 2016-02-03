# dotfiles

## install

```sh
$ install.sh
```

installs os x command line tools, homebrew, homebrew packages, cask
applications, dotfiles, vundle (to manage vim plugins), nvm (to manage node
versions) & global packages from npm.

## dotfiles

you can also just update your shell's dotfiles:

```bash
./bootstrap.sh
```

## env variables, credentials, etc

if `~/.extra` exists, it will be sourced along with the other files. this is
best adding commands you don't want to commit to a public repository.

mine looks something like this:

```bash
# PATH additions
PATH="/usr/local/bin"
PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"
PATH="$PATH:/usr/bin"
PATH="$PATH:/bin"
PATH="$PATH:/usr/sbin"
PATH="$PATH:/sbin"
PATH="$PATH:/usr/local/sbin"
export PATH

MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# git credentials
GIT_AUTHOR_NAME="Axel Anderson"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="axelav@mailinator.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
GIT_GITHUB_USER="axelav"
git config --global github.user "$GIT_GITHUB_USER"
GIT_GITHUB_TOKEN="yourlongassgithubtoken66642069"
git config --global github.token "$GIT_GITHUB_TOKEN"

# aws
export AWS_ACCESS_KEY_ID="yoursecretawskey"
export AWS_SECRET_ACCESS_KEY="yoursecressaccesskey"
export AWS_DEFAULT_REGION="your-mom"

# personal exports
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
export WORKON_HOME=~/.virtualenvs
export GOPATH="$HOME/projects/go-packages"
```

### os x defaults

decent defaults when settings up a new mac:

```bash
./.osx
```
