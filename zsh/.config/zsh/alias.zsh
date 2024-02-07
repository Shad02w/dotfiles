unsetopt BEEP

# common alias
alias ..="cd .."
alias :q=exit
alias so="source $HOME/.zshrc"
alias dot="cd $HOME/dotfiles"
alias nv="nvim"

# git
if type "git" > /dev/null; then
    alias graph="git log --graph  --pretty=format:\"%C(auto)%h%Creset %C(cyan)%an%Creset %Cgreen%ad%Creset %C(auto)%d%Creset %n%s%n\" --date=format:\"%Y-%m-%d %H:%M:%S\""
    alias restash="git pull --rebase --autostash"
    alias gs="git status"
    alias ga="git add"
    alias gc="git commit"
    alias gw="git worktree"
fi

# eza
if type "eza" > /dev/null; then
    alias l="eza --icons"
    alias ls="eza -a --icons"
    alias la="eza -a --icons -albl --git"
    alias ll="eza -lah --icons"
fi

# shell-gpt
if type "sgpt" > /dev/null; then
    alias ss="sgpt -s"
fi

# bat - better cat
if type "bat" > /dev/null; then
    alias cat="bat"
fi

# javascript
yarn() {
    echo "use ni instead, stupid"
}

pnpm() {
    echo "use ni instead, stupid"
}

# ni
if type "ni" > /dev/null; then
    alias nb="nr build"
    alias nt="nr test"
    alias ns="nr start"
    alias nx="na dlx"
    vite-react() {
        na create vite $argv[1] --template=react-ts
    }
    vite-svelte() {
        na create vite $argv[1] --template=svelte-ts
    }

    vite-solid() {
        na create vite $argv[1] --template=solid-ts
    }
fi

# neovim
if type "nvim" > /dev/null; then
    nvx() {
        NVIM_APPNAME=$argv[1] nvim $argv[2]
    }
    nv_uninstall() {
        local name=${1:-nvim}
        rm -rf ~/.local/share/$name && rm -rf ~/.local/state/$name && rm -rf ~/.cache/$name
    }
fi

confirm_rm() {
    local ans
    echo -n "Are you sure? [y/N] "
    read ans
    if [[ $ans =~ ^[Yy]$ ]]; then
        command rm "$@"
    fi
}

alias rm='confirm_rm'

# aws
if type "aws" > /dev/null; then
    set-aws-default-profile() {
        export AWS_PROFILE=$argv[1]
    }
fi

# python3
if type "python3" > /dev/null; then
    alias venv="python3 -m venv"
    alias py="python3"
fi
