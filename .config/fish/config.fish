#LINUX
set -x XDG_CONFIG_HOME $HOME/.config
#GO
set -x GOPATH $HOME/Code/Go
#PATH
set PATH $HOME/bin /usr/local/bin /usr/local/go/bin $GOPATH/bin $PATH
#AWS
set -x AWS_PROFILE default
set -x AWS_REGION ap-southeast-2
#FISH
bind \cH backward-kill-word
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_showdirtystate yes

if status is-interactive
    # lazy load home dir homebrew
    if test -d $HOME/homebrew/bin/
        eval ($HOME/homebrew/bin/brew shellenv)
    end
    # lazy load bun
    if test -d $HOME/.bun
        set -Ux BUN_INSTALL "/Users/jpx15/.bun"
        set -px --path PATH "/Users/jpx15/.bun/bin"
    end
    # lazy fishenv
    if test -f $HOME/.config/fishenv/env.fish
        . $HOME/.config/fishenv/env.fish
    end
end

function fish_greeting
end

function fish_prompt
    if test $status -eq 0
        set_color cyan
    else
        set_color red
    end
    set --local h (string replace ".local" "" (hostname))
    if string match -q "x15*" "$h"
        echo -n x15
    else
        echo -n "$h"
    end
    echo -n ' '
    set_color $fish_color_cwd
    set --local wd "$PWD"
    set --local wd (string replace "$HOME" "~" "$wd")
    echo -n "$wd"
    set_color normal
    if set branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        echo -n " ("
        set_color yellow
        echo -n "$branch"
        set_color normal
        echo -n ")"
    end
    set_color normal
    echo -n ' '
end

function l
    if test (count $argv) -eq 0
        # brew tap homebrew/cask-fonts
        # brew install --cask font-hack-nerd-font
        exa -lah --icons
    else
        exa $argv
    end
end

function k
    kubectl $argv
end

function c
    bat --style=snip --paging=never $argv
end

function lsp
    lsof -i -n -P
end

function xgit
    git --git-dir=$HOME/.config/jpillora-dotfiles/ --work-tree=$HOME $argv
end

function xgitx
    xgit diff --exit-code
    if test $status -eq 0
        echo "no changes"
        return
    end
    echo
    while true
        read -P "sync these changes? y/n " ANS
        if test "$ANS" = y
            xgit add -u; and xgit commit -m updated; and xgit push
            break
        else if test "$ANS" = n
            echo cancelled
            break
        end
    end
end

function install-fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

function install-nvm
    fisher install jorgebucaran/nvm.fish; and set --universal nvm_default_version lts
end

function setup-git
    git config --global gpg.format ssh
    git config --global user.signingkey (cat ~/.ssh/id_ed25519.pub)
end

function gitaddpush
    set msg "$argv"
    if [ "$msg" = "" ]
        set msg updated
    end
    git add -A; and git commit -m "$msg"; and git push
end
