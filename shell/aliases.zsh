# vim: set ft=zsh:

WIFI_PORT='en0'

alias src='source $HOME/.zshrc'
alias wat='man'
alias ffs='sudo'
alias py='python3'
alias ls='ls -FG'
alias sl='ls'
alias watch='date +"%r"'
alias utc='date -u +"%Y-%m-%dT%H:%M:%SZ"'
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
alias fuosx="sudo spctl --master-disable"
alias gw='./gradlew'
alias kc='kubectl'
alias md='vim -c :MarkdownPreview'
alias jql='jq -C | less -R'

alias dcc='docker compose'
alias dstopped='docker ps -a --filter "status=exited" --format "{{.Names}}"'

# docker ps -q → get all container IDs
# xargs
# | -L 1 → use 1 arg per process
# | -P n → spawn n processes
# |     $(docker ps -q | wc -l) → count number of containers to use as n
# | -I replstr → define a replstr, curly braces, to replace in command
# | bash -c "…" → run this command
# |     docker logs --since 30s -f {} → follow logs for each container
# awk
# | container=foo → store a variable "container"
# | docker inspect … | tr … → get container name from id to use as foo, trim slash
# | print … → print the log lines prefixed with [container] in purple
# Moving this to dlf() in func.zsh if it's given no arguments, leaving this here temporarily in case the muscle memory is too deep-rooted
# alias dlogs='docker ps -q | xargs -L 1 -P $(docker ps -q | wc -l) -I {} bash -c "docker logs --since 30s -f {} | awk -v container=\$(docker inspect --format \"{{.Name}}\" {} | tr -d \"/\") '\''{ print \"\033[35m[\" container \"]\033[0m    \" \$0 }'\''"'
