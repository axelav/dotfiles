# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with GNU Stow for macOS development. The repository contains configuration files for a variety of development tools organized by application in individual directories.

## Installation Commands

### Initial setup (new machine)
```bash
./install.sh
```

### Install specific configurations
```bash
stow <directory-name> --verbose
# Example: stow nvim git zsh tmux
```

### Apply macOS system defaults
```bash
./macos
```

### Install Homebrew packages
```bash
brew bundle install --file ./Brewfile
```

## Key Components

### Shell Configuration (zsh/)
- **Main config**: `.zshrc` with oh-my-zsh, plugins, and tool integrations
- **Custom files**: `.aliases`, `.exports`, `.functions` - sourced automatically if they exist
- **Extensions**: Uses zsh-autosuggestions, zsh-syntax-highlighting, atuin (shell history), starship (prompt)

### Development Environment
- **Editor**: Neovim with LazyVim distribution
- **Terminal**: Alacritty/Ghostty with tmux multiplexer
- **Git**: Delta for diff viewing, GPG signing enabled, conditional includes for work
- **Tools**: fzf, ripgrep, bat, lsd, fd, and many other modern CLI utilities

### Neovim Configuration (nvim/.config/nvim/)
- **Distribution**: LazyVim with extensive customizations
- **Theme**: Catppuccin Macchiato with transparency
- **LSP**: Configured for TypeScript, Lua, Markdown (markdown-oxide), and more
- **Key plugins**: Flash navigation, Oil file manager, Snacks terminal
- **Plugin configuration**: Prefer adding plugin configs directly in `lua/config/lazy.lua` rather than splitting into separate files in `lua/plugins/`

### Productivity Setup
- **Knowledge Management**: Custom functions for note-taking (`today`, `now`, `month`)
- **Navigation**: Zoxide for smart directory jumping, custom aliases for common paths
- **Search**: Enhanced ripgrep with fzf integration (`frg` function)

## Important File Locations

- Shell configuration sources from: `~/.{exports,aliases,functions,extra}`
- Kaizen directory for notes: `~/kaizen/`
- Code directory: `~/s/`
- Git config includes work-specific config at: `~/.gitconfig-axionray`

## Development Workflow

### Common directory shortcuts
- `s` - navigate to ~/s (main code directory)
- `k` - navigate to ~/kaizen (notes/journal)
- `oo` - open current directory in Finder

### Useful functions
- `tt` - create temporary git repo with timestamp
- `frg <pattern>` - interactive ripgrep with fzf and bat preview
- `v [file]` - open nvim (with session restoration if Session.vim exists)
- `x` - file explorer with xplr then edit selected file

### Git workflow
- Delta pager for enhanced diffs
- GPG signing enabled by default
- Uses `current` push strategy with auto-setup remote
- Lazygit available via `gg` alias

## Agent Workflow

### Worktrees
- Use `.worktrees/` for feature workspaces unless the change is a single line or otherwise very simple.

### Commits
- Commit each verified logical unit of work incrementally; commits must be GPG-signed.
- Use conventional commits: `type(scope): description`, with a concise lowercase description. Valid types: `feat`, `fix`, `chore`, `test`, and `docs`.

### Pull Requests
- Once implementation, verification, and code review are complete, push the branch and create a draft PR. Share its URL. Only create a ready-for-review PR or mark a draft ready for review when explicitly requested by the user.
- Do not post comments directly to GitHub issues or pull requests; present proposed comments for the user to post.

### Deferred Work
- Record explicitly deferred work in a `## Future Work` section at the end of the plan document, using `- [ ] <description>` for each item.

### Node.js
- Prefer pnpm for new Node.js projects and use `pnpm install` for dependencies.

## macOS Integration

- Screenshots save to ~/Documents/Screenshots
- Various macOS defaults optimized for development
- Homebrew installed to /opt/homebrew
- Terminal integration with system services

## Package Management

- **Homebrew**: Core package manager, Brewfile contains all packages/casks
- **Neovim**: Lazy.nvim plugin manager with lockfile
- **Tmux**: TPM (Tmux Plugin Manager) for session management
- **Shell**: oh-my-zsh with custom plugins

## Environment Variables

Key environment variables set in `.exports`:
- `EDITOR=nvim`
- `MANPAGER="nvim +Man!"`
- `XDG_CONFIG_HOME="$HOME/.config"`
- FZF configured to use ripgrep with git-aware file filtering