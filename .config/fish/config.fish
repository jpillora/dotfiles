set -x GOPATH $HOME/Code/Go
set PATH $HOME/bin /usr/local/bin /usr/local/go/bin $GOPATH/bin $PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

function fish_prompt
  set_color cyan
  echo -n $USER
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
  if set branch (git rev-parse --abbrev-ref HEAD 2> /dev/null);
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

function dotgit
  /usr/bin/git --git-dir=$HOME/.config/jpillora-dotfiles/ --work-tree=$HOME $argv
end
