# zoxide
if type "zoxide" > /dev/null; then
    eval "$(zoxide init zsh)"
fi

# starship 
if type "starship" > /dev/null; then
    eval "$(starship init zsh)"
fi
