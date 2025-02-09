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

# Formats docker ps output and checks for downed containers
# Warrants cleanup eventually
dps()
{
    dockerps=$(docker ps --format "{{.Names}}\n\tContainer ID: {{.ID}}\n\tImage: {{.Image}}\n\tStatus: {{.Status}}\n\tPorts: {{.Ports}}")
    dpsnames=$(docker ps --format "{{.Names}}")
    ccount=$(docker ps -q | wc -l | awk '{print $1}')
    echo "$dockerps"
    echo "\e[32mContainer Count: $ccount\e[0m"

    if [ -f "$HOME/.dps" ]; then
        old_ccount=$(head -n 1 $HOME/.dps)
        if ((old_ccount > ccount)); then
            cdiff=$((old_ccount - ccount))
            olddpsnames=$(tail -n +2 $HOME/.dps)

            # gross
            dpsdiff=$(echo "$olddpsnames" | sed 's/ \n/\n/g' | sort | uniq | comm -23 - <(echo "$dpsnames" | sed 's/ \n/\n/g' | sort | uniq))

            echo "\e[35mINFO: $cdiff fewer container(s) since last run!\e[0m\n\e[34m$dpsdiff\e[0m"
        fi
    else
        echo "No previous container record"
    fi
    echo "$ccount\n$dpsnames" > $HOME/.dps
}
