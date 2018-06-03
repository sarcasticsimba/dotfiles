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
alias tat='tmux attach -t'
alias grep='grep --color'
alias w3m='w3m -no-mouse'

alias clippwd='pwd | pbcopy'
alias clipcd='cd $(pbpaste)'
alias pwdclip='pwd | pbcopy'
alias cdclip='cd $(pbpaste)'

alias wifi="networksetup -setairportpower $WIFI_PORT"
alias wifinetwork="networksetup -getairportnetwork $WIFI_PORT"
alias fdss="find . -name '*.DS_Store' -type f -delete -print"

