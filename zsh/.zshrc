source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/vi.zsh"
source "$HOME/.config/zsh/completions.zsh"
source "$HOME/.config/zsh/title.zsh"
source "$HOME/.config/zsh/external.zsh"
source "$HOME/.config/zsh/path.zsh"


# plugins
eval "$(sheldon source)"

# bun completions
[ -s "/Users/alvistse/.bun/_bun" ] && source "/Users/alvistse/.bun/_bun"


# spaceship 
if type "spaceship" > /dev/null; then
    if [[ "$TERM_PROGRAM" == "WarpTerminal" ]]; then
        SPACESHIP_PROMPT_ASYNC=false
        SPACESHIP_PROMPT_ORDER=()
    fi
    # spaceship vi_mode
    spaceship add --after line_sep vi_mode
    spaceship_vi_mode_enable
fi


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

