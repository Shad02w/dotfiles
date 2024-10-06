# zoxide
if type "zoxide" > /dev/null; then
    eval "$(zoxide init zsh)"
fi



# asdf from brew
if type brew >/dev/null; then
    if type asdf >/dev/null; then
        ASDF_SH="$(brew --prefix asdf)/libexec/asdf.sh"
        if [ -f "$ASDF_SH" ]; then
            . "$ASDF_SH"
        fi
    fi
fi
