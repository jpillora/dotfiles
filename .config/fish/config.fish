set -x GOPATH $HOME/Code/Go
set PATH $HOME/bin /usr/local/bin /usr/local/go/bin $GOPATH/bin $PATH

if status is-interactive
    # lazy load home dir homebrew
    if test -d $HOME/homebrew/bin/
        eval ($HOME/homebrew/bin/brew shellenv)
    end
end

function fish_greeting
end

#fix slow autocomplete
function __fish_describe_command
end
funcsave __fish_describe_command

function fish_prompt
    set_color cyan
    echo -n $hostname
    echo -n ' '
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal
    echo -n ' '
end

function prompt_pwd --description 'modify pwd to shorten paths, add git branch'
    set wd "$PWD"
    set wd (string replace "$HOME" "~" "$wd")
    set_color green
    echo -n "$wd"
    set_color normal
    if set branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        echo -n " ("
        set_color yellow
        echo -n "$branch"
        set_color normal
        echo -n ")"
    end
    echo ""
end

function l
    exa $argv
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
    read -P "sync these changes? y/n (default y) " ANS
    if test "$ANS" = y || test "$ANS" = ""
        dotgit add -u; and dotgit commit -m updated; and dotgit push
    end
end

function install-fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

function install-nvm
    fisher install jorgebucaran/nvm.fish; and set --universal nvm_default_version lts
end
