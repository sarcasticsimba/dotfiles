# This is my .zshrc
# It builds off of @vilhalmer's:
#   https://github.com/vilhalmer/System

typeset -U PATH    #prevents duplicate PATH entries

source $HOME/.profile
source $HOME/.private

HISTFILE=$HOME/.zsh_history
setopt APPEND_HISTORY
HISTSIZE=1200
SAVEHIST=1000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
#setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE

figlet -f univers Vignesh

# Aliases
source $HOME/.aliases

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

# Display the exit status of the last command as a green/red status light, and
# Print out the code if it's > 0.
RPROMPT="%(?.%F{green}.%F{red}%? )%{%G•%}%f"

# Prompt 
source $HOME/.prompt

precmd () {
    build_prompt
}

# Functions
mkcd() {
    mkdir -p $1 && cd $1
}

cdls() {
    if [[ -z $2 ]]; then
        cd $1 && ls
    else
        cd $2 && ls $1
    fi
}

wtoggle() {
    wifi off
    sleep 2
    wifi on 
}

