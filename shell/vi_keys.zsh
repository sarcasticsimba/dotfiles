bindkey -v
function zle-keymap-select zle-line-init
{
    if [[ $TMUX != "" ]]
    then
        case $KEYMAP in
            vicmd)      print -n -- "\033Ptmux;\033\E]50;CursorShape=2\C-G\033\\";;
            viins|main) print -n -- "\033Ptmux;\033\E]50;CursorShape=0\C-G\033\\";;
        esac
    else
        case $KEYMAP in
            vicmd)      print -n -- "\E]50;CursorShape=2\C-G";;
            viins|main) print -n -- "\E]50;CursorShape=0\C-G";;
        esac
    fi
}

function zle-line-finish
{
    if [[ $TMUX != "" ]]
    then
        print -n -- "\033Ptmux;\033\E]50;CursorShape=0\C-G\033\\"
    else
        print -n -- "\E]50;CursorShape=0\C-G"
    fi
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

if [[ $TMUX != "" ]]
then
    print -n -- "\033Ptmux;\033\E]50;CursorShape=0\C-G\033\\"
else
    print -n -- "\E]50;CursorShape=0\C-G"
fi

precmd ()
{
    build_prompt
}
