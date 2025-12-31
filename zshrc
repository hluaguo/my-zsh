# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zsh setup
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"

# Plugins
plugins=(
  git
  zsh-syntax-highlighting
  fzf-tab
)

source $ZSH/oh-my-zsh.sh

# fzf
source <(fzf --zsh)

# fzf Tokyo Night Storm theme
export FZF_DEFAULT_OPTS="
--height=40%
--layout=reverse
--border=rounded
--info=inline
--prompt='> '
--pointer='▶'
--marker='✓'
--color=fg:#c0caf5,bg:#24283b,hl:#ff9e64
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a
"

# Use fd for file search (faster, respects .gitignore)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude .DS_Store'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Preview with bat
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# fzf-tab settings
zstyle ':fzf-tab:*' continuous-trigger ''
zstyle ':fzf-tab:*' fzf-flags --height=40% --layout=reverse --border \
  --color=fg:#c0caf5,bg:#24283b,hl:#ff9e64 \
  --color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
  --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
  --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -la $realpath'
zstyle ':fzf-tab:complete:cat:*' fzf-preview 'bat --color=always --style=numbers $realpath 2>/dev/null || cat $realpath'
zstyle ':completion:*' special-dirs true

# Bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Go
export PATH="$HOME/go/bin:$PATH"

# Clojure
export JAVA_HOME=/opt/homebrew/opt/openjdk
export PATH="$JAVA_HOME/bin:$PATH"

# Aliases
[ -f ~/.aliases ] && source ~/.aliases
