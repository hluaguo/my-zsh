#!/bin/bash
set -e

DOTFILES_DIR="$HOME/dotfiles"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[+]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[x]${NC} $1"; exit 1; }

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

# Remove existing symlinks/files before stowing
log "Cleaning up existing configs..."
rm -f "$HOME/.zshrc" "$HOME/.aliases"
rm -rf "$HOME/.config/sketchybar"
rm -rf "$HOME/.config/aerospace"
rm -f "$HOME/.config/karabiner/karabiner.json"
rm -f "$HOME/Library/Application Support/Code/User/settings.json"
rm -f "$HOME/Library/Application Support/Code/User/keybindings.json"

# Create necessary directories
mkdir -p "$HOME/.config/karabiner"
mkdir -p "$HOME/Library/Application Support/Code/User"

# Use stow to symlink dotfiles
log "Stowing dotfiles..."
cd "$DOTFILES_DIR"
stow -v zsh
stow -v sketchybar
stow -v aerospace
stow -v karabiner
stow -v vscode

# Install VS Code extensions
log "Installing VS Code extensions..."
if [ -f "$DOTFILES_DIR/extensions.txt" ]; then
    while IFS= read -r extension || [ -n "$extension" ]; do
        [ -z "$extension" ] && continue
        code --install-extension "$extension" --force 2>/dev/null || warn "Failed to install: $extension"
    done < "$DOTFILES_DIR/extensions.txt"
fi

# iTerm2 settings
if [ -f "$DOTFILES_DIR/tokyo-night-storm.itermcolors" ]; then
    log "iTerm2 color preset available at: $DOTFILES_DIR/tokyo-night-storm.itermcolors"
    warn "Import manually via iTerm2 > Settings > Profiles > Colors > Color Presets"
fi

echo ""
log "Installation complete!"
log "Run: source ~/.zshrc"
