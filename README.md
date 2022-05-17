# dotfiles

My configuration for:

* fish
* tmux
* ssh

Plus a some handy scripts


## Initialise

This repo is intended to be cloned as a bare repo

https://www.atlassian.com/git/tutorials/dotfiles

```sh
# clone the bare repo (git metadata only)
mkdir -p $HOME/.config/
git clone --bare https://github.com/jpillora/dotfiles.git $HOME/.config/jpillora-dotfiles
# attempt to checkout files into $HOME (can be clashes)

```


## Usage

```sh
# git command using the initialised bare repo
dotgit <git command>
```
