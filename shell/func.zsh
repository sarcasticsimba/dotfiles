# vim: set ft=zsh:

mkcd()
{
    mkdir -p $1 && cd $1
}

cdls()
{
    if [[ -z $2 ]]; then
        cd $1 && ls
    else
        cd $2 && ls $1
    fi
}

wtoggle()
{
    wifi off
    sleep 2
    wifi on 
}

count()
{
    cat $1 | tr -d ' \n' | wc -c;
}

cgitignore()
{
    echo "*.*\n!*.c\n!*.h\n" >> .gitignore
}

clip()
{
    cat $1 | pbcopy;
}