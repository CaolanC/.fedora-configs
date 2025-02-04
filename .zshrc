# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep notify
bindkey -v
# End of lines configured by zsh-newuser-install

# Install Zinit if not already installed
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} Installing Zinit Plugin Manager...%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} Installation successful.%f" || \
        print -P "%F{160} The clone has failed.%f"
fi

# Source Zinit after installation
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# Autoload Zinit functionality
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load Zinit annexes and plugins (light-mode for speed)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Load other plugins
zinit ice atpull'!git reset --hard'
zinit light sindresorhus/pure

zinit ice blockf wait'!0'
zinit light zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#11c486"

zinit light zsh-users/zsh-syntax-highlighting

# Set up key bindings
bindkey '^' autosuggest-accept
bindkey '^U' kill-whole-line
bindkey '^A' beginning-of-line

if [ -z "$TMUX" ]; then
	tmux a -t main || tmux new -s main
fi

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

#zoxide setup
eval "$(zoxide init zsh)"

alias n="nvim"
alias fbat='fzf -m --preview="bat --color=always {}"'
alias fn='nvim $(fbat)'
alias cd='z'

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

export PATH="$PATH:/home/cochrac2/bin/"


# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
