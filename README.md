# dotfiles

## Installation

Install MacOS command line tools, homebrew, homebrew packages/casks, dotfiles,
etc.

```sh
$ install.sh
```

## Usage

Use `stow` to install symlinks to your dotfiles:

`stow git gpg <...> --verbose`

[source](https://stevenrbaker.com/tech/managing-dotfiles-with-gnu-stow.html)

## `env` vars, credentials, etc

If `~/.extra` exists, it will be sourced along with the other files. This is
best adding commands you don't want to commit to a public repository.

### MacOS defaults

Decent defaults when settings up a new machine:

```sh
./macos
```
