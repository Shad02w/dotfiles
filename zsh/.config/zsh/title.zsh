function set_win_title(){
    echo -ne "\033]0;$(basename $PWD) $HISTCMD\007"
}

precmd_functions+=(set_win_title)
