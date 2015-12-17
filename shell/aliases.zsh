# vim: set ft=zsh:

WIFI_PORT='en0'

alias src='source $HOME/.zshrc'
alias wat='man'
alias ffs='sudo'
alias py='python'
alias ls='ls -FG'
alias sl='ls'
alias watch='date +"%r"'
alias battery='sh $HOME/dotfiles/ncscripts/battery.sh'
alias notes='cd $HOME/Documents/notes'

alias clippwd='pwd | pbcopy'
alias clipcd='cd $(pbpaste)'
alias pwdclip='pwd | pbcopy'
alias cdclip='cd $(pbpaste)'

alias wifi="networksetup -setairportpower $WIFI_PORT"
alias wifinetwork="networksetup -getairportnetwork $WIFI_PORT"
