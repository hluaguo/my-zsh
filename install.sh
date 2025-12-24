#!/bin/bash

echo "Installing dotfiles..."

# Install Homebrew if missing
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install dependencies
echo "Installing dependencies..."
brew install fzf fd bat git zoxide go uv 

# Install applications
echo "Installing applications..."
brew install --cask visual-studio-code google chrome maccy obsidian rectangle font-jetbrain-mono font-jetbrain-mono-nerd-font tree

# Install oh-my-zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install plugins
echo "Installing zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/fzf-tab" ]; then
    git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"
fi

# Symlink dotfiles
echo "Creating symlinks..."
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/aliases ~/.aliases

# Symlink VS Code settings
echo "Linking VS Code settings..."
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_USER_DIR"
ln -sf ~/dotfiles/vscode/settings.json "$VSCODE_USER_DIR/settings.json"
ln -sf ~/dotfiles/vscode/keybindings.json "$VSCODE_USER_DIR/keybindings.json"

# Install VS Code extensions
echo "Installing VS Code extensions..."
if [ -f ~/dotfiles/vscode/extensions.txt ]; then
    while read -r extension; do
        code --install-extension "$extension" --force
    done < ~/dotfiles/vscode/extensions.txt
fi

echo "Done! Restart your terminal or run: source ~/.zshrc"
echo "Note: Set iTerm2 color preset via Settings > Profiles > Colors > Color Presets"
