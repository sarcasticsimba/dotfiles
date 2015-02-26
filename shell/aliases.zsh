# vim: set ft=zsh:

# Aliases

alias src='source $HOME/.zshrc'
alias wat='man'
alias ffs='sudo'
alias py='python'
alias wifi='networksetup -setairportpower airport'
alias gitjk="history 10 | tail -r | gitjk_cmd"
alias zshrc='vim $HOME/.zshrc'
alias sl='ls'
alias watch='date +"%r"'
alias battery='sh $HOME/dotfiles/ncscripts/battery.sh'
alias notes='cd $HOME/Documents/notes'
alias lynx='lynx -vikeys'
alias pwdclip='pwd | pbcopy'
alias cdclip='cd $(pbpaste)'