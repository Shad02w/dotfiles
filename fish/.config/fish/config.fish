# Path 
set PATH $PATH /opt/local/bin
set PATH $PATH /opt/homebrew/bin
set PATH $PATH ~/Library/Python/3.9/bin

set -gx MYVIMRC ~/.config/nvim/init.vim
set -gx RANGER_LOAD_DEFAULT_RC FALSE

# Android Path
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx ANDROID_SDK_ROOT $HOME/Library/Android/sdk
set PATH $PATH "$ANDROID_HOME/tools"
set PATH $PATH "$ANDROID_HOME/tools/bin"
set PATH $PATH "$ANDROID_HOME/platform-tools"
set PATH $PATH "$ANDROID_HOME/emulator"

# Go
set PATH $PATH "~/go/bin"
set -gx GOROOT "/usr/local/go"
set -gx GOPATH "$HOME/go"

set CC /usr/bin/clang
set CXX "/usr/bin/clang++"

# Common Alias
alias dev "cd ~/Documents/dev"
alias pinnacle "cd ~/Documents/dev/pinnacle"
alias p0 "cd ~/Documents/dev/pinnacle"

alias b brew
alias mp port
alias ra ranger

alias nv nvim
alias nvd neovide

alias antlr4 "java -jar /usr/local/bin/antlr-4.11.1-complete.jar"
alias grun='java -cp .:/usr/local/bin/antlr-4.11.1-complete.jar org.antlr.v4.gui.TestRig'

# Pnpm Alias
# if type -q pnpm
#     alias pi "pnpm install"
#     alias pr "pnpm run"
#     alias pt "pnpm test"
#     alias pst "pnpm start"
#     alias pa "pnpm add"
#     alias pb "pnpm build"
#     alias pnx "pnpm nx"
#     alias pw "pnpm why"
#     function vite-react --description "pnpm create vite-react-ts"
#         pnpm create vite $argv[1] -- --template=react-ts
#     end
# end

# ni alias
alias nb "nr build"
alias nt "nr test"
alias ns "nr start"
alias nxx "na nx"
function vite-react --description "pnpm create vite-react-ts"
    na create vite $argv[1] --template=react-ts
end

function vite-react --description "pnpm create vite-react-ts"
    na create vite $argv[1] --template=react-ts
end

function pnpm
    echo "use ni stupid"
end

function yarn
    echo "use ni stupid"
end

if type -q cargo
    alias cn "cargo new"
    alias cr "cargo run"
    alias cb "cargo build"
    alias cc "cargo check"
end


if type -q git
    alias graph "git log --graph  --pretty=format:\"%C(auto)%h%Creset %C(cyan)%an%Creset %Cgreen%ad%Creset %C(auto)%d%Creset %n%s%n\" --date=format:\"%Y-%m-%d %H:%M:%S\""
    alias restash "git pull --rebase --autostash"
    alias gs "git status"
    alias ga "git add"
    alias gc "git commit"
    alias gw "git worktree"
end


# nvm fish
set --universal nvm_default_version v18.12.1

# Alias for exa
if type -q exa
    alias l "exa --icons"
    alias ls "exa -a --icons"
    alias la "exa -a --icons -albl --git"
    alias ll "exa -lah --icons"
end

if type -q java
    set -gx JAVA_17_HOME (/usr/libexec/java_home -v 17)
    set -gx JAVA_11_HOME (/usr/libexec/java_home -v 11)
    set -gx JAVA_HOME $JAVA_11_HOME
    alias java17 "set JAVA_HOME $JAVA_17_HOME"
    alias java11 "set JAVA_HOME $JAVA_11_HOME"
end

if status is-interactive
    # Commands to run in interactive sessions can go here

    # vim mode 
    fish_vi_key_bindings
end


# asdf
source ~/.asdf/asdf.fish
# fzf
source  /opt/local/share/fzf/shell/key-bindings.fish

function fish_greeting
end

function fish_prompt --description 'Write out the prompt with git'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    if not set -q __fish_git_prompt_show_informative_status
        set -g __fish_git_prompt_show_informative_status 1
    end
    if not set -q __fish_git_prompt_hide_untrackedfiles
        set -g __fish_git_prompt_hide_untrackedfiles 1
    end
    if not set -q __fish_git_prompt_color_branch
        set -g __fish_git_prompt_color_branch magenta --bold
    end
    if not set -q __fish_git_prompt_showupstream
        set -g __fish_git_prompt_showupstream informative
    end
    if not set -q __fish_git_prompt_color_dirtystate
        set -g __fish_git_prompt_color_dirtystate blue
    end
    if not set -q __fish_git_prompt_color_stagedstate
        set -g __fish_git_prompt_color_stagedstate yellow
    end
    if not set -q __fish_git_prompt_color_invalidstate
        set -g __fish_git_prompt_color_invalidstate red
    end
    if not set -q __fish_git_prompt_color_untrackedfiles
        set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    end
    if not set -q __fish_git_prompt_color_cleanstate
        set -g __fish_git_prompt_color_cleanstate green --bold
    end

    set -l color_cwd
    set -l suffix
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        else
            set color_cwd $fish_color_cwd
        end
        set suffix '#'
    else
        set color_cwd $fish_color_cwd
        set suffix '$'
    end

    # Username
    set_color yellow
    printf '%s [%s]' $USER $suffix
    set_color normal
    printf ' at '

    # PWD
    set_color $color_cwd
    echo -n (prompt_pwd)
    set_color normal

    printf '%s ' (fish_vcs_prompt)

    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color --bold $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
    echo -n $prompt_status
    set_color normal

    echo -e "\n↪ "
end


# gvm
if test -f ~/.gvm/environments/default
    bass source ~/.gvm/environments/default
end

# bun
function bun
    bass bun $argv
end

# rust 
bass source $HOME/.cargo/env
# set PATH $PATH ~/.cargo/bin


function setDefaultVersion
    if type -q nvm
        nvm use 18 
    end
end

setDefaultVersion &> /dev/null

function add_new_line --on-event fish_postexec
    echo
end
# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# pnpm
set PNPM_HOME "$HOME/Library/pnpm"
set PATH "$PNPM_HOME" $PATH
# pnpm end



# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

#rbenv
if status is-interactive
    # ~/.rbenv/bin/rbenv init - fish | source
    /opt/homebrew/bin/rbenv init - fish | source
end


