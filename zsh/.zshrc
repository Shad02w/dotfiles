source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/compeletions.zsh"
source "$HOME/.config/zsh/external.zsh"
source "$HOME/.config/zsh/vi.zsh"


# starship 
if type "starship" > /dev/null; then
    eval "$(starship init zsh)"
fi

#plugins
eval "$(sheldon source)"



