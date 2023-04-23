source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/vi.zsh"
source "$HOME/.config/zsh/completions.zsh"
source "$HOME/.config/zsh/title.zsh"
source "$HOME/.config/zsh/external.zsh"

# plugins
eval "$(sheldon source)"

# bun completions
[ -s "/Users/alvistse/.bun/_bun" ] && source "/Users/alvistse/.bun/_bun"


# spaceship vi mode
# if type "spaceship" > /dev/null; then
#     spaceship add --after line_sep vi_mode
# fi

