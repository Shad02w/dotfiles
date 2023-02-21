export fpath=($HOME/.config/zsh/completions $fpath) 

autoload -U compinit
compinit

setopt MENU_COMPLETE
_comp_options+=(globdots) # With hidden files


# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
# Allow you to select in a menu
zstyle ':completion:*' menu select
# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

