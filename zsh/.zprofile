# Fig pre block. Keep at the top of this file.
# [[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && . "$HOME/.fig/shell/zprofile.pre.zsh"
# eval "$(/opt/homebrew/bin/brew shellenv)"

# common path
export PATH="/opt/local/bin":$PATH
export PATH="/opt/homebrew/bin":$PATH

# fnm
if type "fnm" > /dev/null; then
    eval "$(fnm env --use-on-cd)"
fi