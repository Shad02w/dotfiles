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
if type "spaceship" > /dev/null; then
    eval "$(spaceship_vi_mode_enable)"
    spaceship add --after line_sep vi_mode
fi


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
