# disable zsh session
export SHELL_SESSIONS_DISABLE=1

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

# go
if [[ -d "$HOME/go/bin" ]]; then
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin":$PATH
fi

if [[ -d "/usr/local/go" ]]; then
    export GOROOT="/usr/local/go"
    export PATH="$GOROOT/bin":$PATH
fi

# fnm
if type "fnm" > /dev/null; then
    eval "$(fnm env --use-on-cd)"
fi

# use neovim as git editor
if type "nvim" > /dev/null; then
    export GIT_EDITOR=nvim
fi

# add pyenv path -- tempoary disable because it slow down zsh startup by 100ms😱
if type "pyenv" > /dev/null; then
    eval "$(pyenv init --path)"
fi

# add rbenv path
if type "rbenv" > /dev/null; then
    eval "$(rbenv init - zsh)"
fi

# mac Postgres
if [[ -d /Applications/Postgres.app/Contents/Versions/16/bin ]]; then
    export PATH="/Applications/Postgres.app/Contents/Versions/15/bin":$PATH
fi

# Added by OrbStack: command-line tools and integration
if [[ -d ~/.orbstack/shell ]]; then
    source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi

# tizen-cli
if [[ -d $HOME/tizen-studio ]]; then
    export PATH=$HOME/tizen-studio/tools/ide/bin:$PATH
fi

if type "vfox" > /dev/null; then
    eval "$(vfox activate zsh)"
fi

# herd-lite
if [[ -d $HOME/.config/herd-lite ]]; then
    export PATH="$HOME/.config/herd-lite/bin:$PATH"
    export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
fi

# Added by Windsurf
if [[ -d $HOME/.codeium/windsurf ]]; then
    export PATH="$HOME/.codeium/windsurf/bin:$PATH"
fi
