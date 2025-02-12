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

# Formats docker ps output and checks for container state change
# Creates a file ~/.dps
dps()
{
    docker ps --format "{{.Names}}\n\tContainer ID: {{.ID}}\n\tImage: {{.Image}}\n\tStatus: {{.Status}}\n\tPorts: {{.Ports}}"
    dnames=$(docker ps --format "{{.Names}}")
    ccount=$(echo "$dnames" | awk 'END {print NR}')
    echo "\e[34mContainer Count: $ccount\e[0m"

    if [ -f "$HOME/.dps" ]; then
        olddnames=$(cat $HOME/.dps)

        # gross
        removed=$(comm -23 <(echo "$olddnames" | sort) <(echo "$dnames" | sort) | sed 's/^\t//; s/^/- /')
        added=$(comm -13 <(echo "$olddnames" | sort) <(echo "$dnames" | sort) | sed 's/^\t//; s/^/+ /')

        if [[ -n "$removed" || -n "$added" ]]; then
            echo "\e[35m\nINFO: container configuration changed!\e[0m"
            [[ -n "$removed" ]] && echo "\e[31m$removed\e[0m"
            [[ -n "$added" ]] && echo "\e[32m$added\e[0m"
        fi
    else
        echo "No previous container record"
    fi
    echo "$dnames" > $HOME/.dps
}
