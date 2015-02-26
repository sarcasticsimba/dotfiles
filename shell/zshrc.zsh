# This is my .zshrc
# It builds off of @vilhalmer's:
#   https://github.com/vilhalmer/System

typeset -U PATH    #prevents duplicate PATH entries

source $HOME/dotfiles/shell/profile.zsh
source $HOME/dotfiles/shell/private.zsh

HISTFILE=$HOME/.zsh_history
setopt APPEND_HISTORY
HISTSIZE=1200
SAVEHIST=1000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
#setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE

# Aliases
source $HOME/dotfiles/shell/aliases.zsh

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
setopt auto_cd #Comment out if lame
unsetopt rm_star_silent

# Colors on OS X
alias ls='ls -FG'
export LSCOLORS=dxfxgxexbxchcxBxBxdhDh
export CLICOLOR=1

# Prompt 
source $HOME/dotfiles/shell/prompt.zsh

precmd () {
    build_prompt
}

# Functions
source $HOME/dotfiles/shell/func.zsh

export TERM="xterm"
