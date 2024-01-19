export fpath=($HOME/.config/zsh/completions $fpath) 

autoload bashcompinit 
bashcompinit

autoload -U compinit
compinit


setopt MENU_COMPLETE
_comp_options+=(globdots) # With hidden files


# Zstyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
# Allow you to select in a menu
zstyle ':completion:*' menu select
# Case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands


# enable aws completion
if type aws_completer > /dev/null; then
    complete -C "$(which aws_completer)" aws
fi

