# starship 
if type "starship" > /dev/null; then
    eval "$(starship init zsh)"
fi

# git
if type "git" > /dev/null; then
    alias graph="git log --graph  --pretty=format:\"%C(auto)%h%Creset %C(cyan)%an%Creset %Cgreen%ad%Creset %C(auto)%d%Creset %n%s%n\" --date=format:\"%Y-%m-%d %H:%M:%S\""
    alias restash="git pull --rebase --autostash"
    alias gs="git status"
    alias ga="git add"
    alias gc="git commit"
    alias gw="git worktree"
fi

# exa
if type "exa" > /dev/null; then
    alias l="exa --icons"
    alias ls="exa -a --icons"
    alias la="exa -a --icons -albl --git"
    alias ll="exa -lah --icons"
fi

# javascript
yarn() {
    echo "use ni instead, stupid"
}

pnpm() {
    echo "use ni instead, stupid"
}

# ni
if type "git" > /dev/null; then
    alias nv="nvim"
    alias nb="nr build"
    alias nt="nr test"
    alias ns="nr start"
    alias nxx="na nx"
fi
