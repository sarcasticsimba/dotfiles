# vim: set ft=zsh:

mkcd()
{
    mkdir -p $1 && cd $1
}

cdls()
{
    cd $1 && ls
}

wtoggle()
{
    wifi off
    sleep 2
    wifi on 
}

clip()
{
    cat $1 | pbcopy;
}

fussh()
{
    eval `ssh-agent -s` && ssh-add
}

# Usage: $ notify <body> <title> <subtitle>
notify()
{
    if [ $# -gt 3 ]; then
        echo "notify: More than 3 arguments provided, only using the first 3\nUsage: $ notify <body> <title> <subtitle>"
    fi
    # $ osascript -e 'display notification "hello world!" with title "Command Line" subtitle "Helm" sound name "Boop"'
    body="${1:-n/a}"
    title="${2:-CLI Notification}"
    subtitle="${3:-notify}"

    str="display notification \"$body\" with title \"$title\" subtitle \"$subtitle\" sound name \"Boop\""

    osascript -e "$str"
}
