# dotfiles

## Install

```bash
git clone https://github.com/hugo/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

## What's included

- **Homebrew** - packages & apps via `Brewfile`
- **Zsh** - oh-my-zsh with fzf, syntax highlighting
- **VS Code** - settings, keybindings, extensions
- **Hammerspoon** - window management, monitor switching

## Shortcuts (Hammerspoon)

| Key | Action |
|-----|--------|
| `Opt+Cmd+←/→/↑/↓` | Split window (repeat to cycle 1/2, 1/3, 2/3) |
| `Opt+Cmd+U/I/J/K` | Quarter windows |
| `Opt+Cmd+Return` | Maximize |
| `Opt+Cmd+M` | Move window to next monitor |
| `Opt+Cmd+N` | Focus next monitor |

## Update

```bash
# Export current brew packages
brew bundle dump --file=~/dotfiles/Brewfile --force

# Export VS Code extensions
code --list-extensions > ~/dotfiles/vscode/extensions.txt
```
