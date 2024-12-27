function set_win_title() {
    current_path=$(pwd)
    last_dir=$(basename "$current_path")
    second_last_dir=$(basename "$(dirname "$current_path")")
    echo -ne "\033]0;${second_last_dir}/${last_dir}\007"
}


autoload -Uz add-zsh-hook
add-zsh-hook precmd set_win_title

