set -x XDG_CONFIG_HOME $HOME/.config
set -x GOPATH $HOME/Code/Go
set -x GOPRIVATE "github.com/12kmps/*"
set PATH $HOME/bin /usr/local/bin /usr/local/go/bin $GOPATH/bin $PATH

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
    set_color cyan
    switch $hostname
        case "x15*"
            echo -n x15
        case '*'
            echo -n $hostname
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

function dotgit
    git --git-dir=$HOME/.config/jpillora-dotfiles/ --work-tree=$HOME $argv
end

function dotgitupdate
    dotgit diff --exit-code
    if test $status -eq 0
        echo "no changes"
        return
    end
    echo
    while true
        read -P "sync these changes? y/n " ANS
        if test "$ANS" = y
            dotgit add -u; and dotgit commit -m updated; and dotgit push
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
