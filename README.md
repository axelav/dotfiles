# Axel's dotfiles

A fork of [mathias's dotfiles](https://github.com/mathiasbynens/dotfiles/) which has a good overview of what all this does.

## Installation

### Install dependencies

My basic setup is captured in `install-deps.sh` which adds homebrew, yeoman, z, etc.

### Install Homebrew formulae

`install-deps.sh` runs this, but if you want to just run it on it's own...you can install some common Homebrew formulae (after installing Homebrew, of course):

```bash
./.brew
```


### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Dropbox/projects/dotfiles`. The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/axelav/dotfiles.git && cd dotfiles && ./bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
./bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
./bootstrap.sh -f
```

### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
# PATH additions
      PATH=/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/bin
PATH=$PATH:~/.rvm/bin
PATH=$PATH:~/code/git-friendly
# ...

export PATH

# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="Axel Anderson"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="axelav@mailinator.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

### Syntax highlighting

...is really important. Even for these files.

Add the below to this file: `~/Library/Application Support/Sublime Text 2/Packages/ShellScript/Shell-Unix-Generic.tmLanguage`

```xml
<string>.aliases</string>
<string>.bash_profile</string>
<string>.bash_prompt</string>
<string>.bashrc</string>
<string>.brew</string>
<string>.exports</string>
<string>.functions</string>
<string>.git</string>
<string>.gitattributes</string>
<string>.gitconfig</string>
<string>.gitignore</string>
<string>.inputrc</string>
<string>.osx</string>
<string>.vim</string>
<string>.vimrc</string>
```

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./.osx
```
