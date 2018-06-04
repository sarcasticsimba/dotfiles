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
