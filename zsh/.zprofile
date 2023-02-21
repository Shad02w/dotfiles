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

# fnm
if type "fnm" > /dev/null; then
    eval "$(fnm env --use-on-cd)"
fi
