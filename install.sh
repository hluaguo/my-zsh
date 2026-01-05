#!/bin/bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[+]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[x]${NC} $1"; exit 1; }

# Backup existing file if it exists and is not a symlink
backup_file() {
    local file="$1"
    if [ -f "$file" ] && [ ! -L "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        cp "$file" "$BACKUP_DIR/"
        warn "Backed up $file to $BACKUP_DIR/"
    fi
}

log "Starting dotfiles installation..."

# Install Homebrew if missing
if ! command -v brew &> /dev/null; then
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install packages from Brewfile
log "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Install oh-my-zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install zsh plugins
log "Installing zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/fzf-tab" ]; then
    git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"
fi

# Backup and symlink dotfiles
log "Creating symlinks..."
backup_file "$HOME/.zshrc"
backup_file "$HOME/.aliases"

ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/aliases" "$HOME/.aliases"

# VS Code settings
log "Linking VS Code settings..."
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_USER_DIR"

backup_file "$VSCODE_USER_DIR/settings.json"
backup_file "$VSCODE_USER_DIR/keybindings.json"

ln -sf "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
ln -sf "$DOTFILES_DIR/vscode/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"

# Install VS Code extensions
log "Installing VS Code extensions..."
if [ -f "$DOTFILES_DIR/vscode/extensions.txt" ]; then
    while IFS= read -r extension || [ -n "$extension" ]; do
        [ -z "$extension" ] && continue
        code --install-extension "$extension" --force 2>/dev/null || warn "Failed to install: $extension"
    done < "$DOTFILES_DIR/vscode/extensions.txt"
fi

# Hammerspoon
log "Linking Hammerspoon config..."
mkdir -p "$HOME/.hammerspoon"
ln -sf "$DOTFILES_DIR/hammerspoon/init.lua" "$HOME/.hammerspoon/init.lua"

# iTerm2 settings
if [ -f "$DOTFILES_DIR/tokyo-night-storm.itermcolors" ]; then
    log "iTerm2 color preset available at: $DOTFILES_DIR/tokyo-night-storm.itermcolors"
    warn "Import manually via iTerm2 > Settings > Profiles > Colors > Color Presets"
fi

echo ""
log "Installation complete!"
log "Run: source ~/.zshrc"
[ -d "$BACKUP_DIR" ] && log "Backups saved to: $BACKUP_DIR"
