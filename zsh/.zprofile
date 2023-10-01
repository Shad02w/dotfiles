HISTSIZE=1000000
SAVEHIST=1000000

# common path
export PATH="/opt/local/bin":$PATH
export PATH="/opt/homebrew/bin":$PATH

export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH="$ANDROID_HOME/tools":$PATH
export PATH="$ANDROID_HOME/tools/bin":$PATH 
export PATH="$ANDROID_HOME/platform-tools":$PATH 
export PATH="$ANDROID_HOME/emulator":$PATH 

# common bin
export PATH="$HOME/.local/bin":$PATH

# rust
if [[ -d "$HOME/.cargo/bin" ]]; then
    export PATH="$HOME/.cargo/bin":$PATH
fi

# fnm
if type "fnm" > /dev/null; then
    eval "$(fnm env --use-on-cd)"
fi

if type "nvim" > /dev/null; then
    export GIT_EDITOR=nvim
fi

# mac Postgres
if [[ -d /Applications/Postgres.app/Contents/Versions/16/bin ]]; then
    export PATH="/Applications/Postgres.app/Contents/Versions/15/bin":$PATH
fi

# Added by OrbStack: command-line tools and integration
if [[ -d ~/.orbstack/shell ]]; then
    source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi
