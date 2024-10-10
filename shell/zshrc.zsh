# Prevents duplicate PATH entries
typeset -U PATH

# History file
HISTFILE=$HOME/.zsh_history
setopt APPEND_HISTORY
HISTSIZE=9216
SAVEHIST=8192
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# zstyles
zstyle ':completion:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' format '%F{blue}Completing %d%f'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent ..
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:]}={[:upper:]}' '+r:|[._-]=** r:|=**' '+'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original false
zstyle ':completion:*' prompt 'Corrections (%e):'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true

# Autocomplete
autoload -Uz compinit
compinit
autoload -U colors && colors

# zsh specific commands
setopt completealiases
setopt hist_ignore_dups
setopt correct
unsetopt rm_star_silent
# setopt auto_cd  # Comment out if lame

# Colors on macOS
export LSCOLORS=dxfxgxexbxchcxBxBxdhDh
export CLICOLOR=1

export TERM="xterm-256color"

# Source my other confs
source $HOME/dotfiles/shell/profile.zsh
source $HOME/dotfiles/shell/prompt.zsh
source $HOME/dotfiles/shell/aliases.zsh
source $HOME/dotfiles/shell/func.zsh
source $HOME/dotfiles/shell/private.zsh
