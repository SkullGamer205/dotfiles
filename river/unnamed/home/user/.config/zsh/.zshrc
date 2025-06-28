# compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# unifetch --config "$HOME/.config/unifetch/config-mini.conf"
fastfetch -c "${XDG_CONFIG_HOME:-${HOME}/.config}/fastfetch/config-mini.jsonc"
export LAMBDA_MOD_N_DIR_LEVELS=1

# Environment
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
EDITOR='nvim'

# Zinit bootstrap
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load Prompt
zinit light miekg/lean

# Load Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load Snippets (OMZ)
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu mo
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls $realpath'

# Aliases
alias vi='nvim'
alias ls='eza --icons'

# Shell integrations
eval "$(fzf --zsh)"			#FZF
eval "$(zoxide init --cmd cd zsh)"	#Zoxide

# Functions
function lk {
    cd "$(walk --icons "$@")"
}

# History
HISTSIZE=10000
HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


