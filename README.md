# dotfiles

My configuration for:

* fish
* tmux
* ssh

Plus a some handy scripts


## Initialise

1. Install `git` and `fish` shell

1. Cloned repo `--bare` (https://www.atlassian.com/git/tutorials/dotfiles)

	```fish
	# clone the bare repo (git metadata only)
	mkdir -p $HOME/.config/
	git clone --bare https://github.com/jpillora/dotfiles.git $HOME/.config/jpillora-dotfiles
	# define dotgit command
	function dotgit; git --git-dir=$HOME/.config/jpillora-dotfiles/ --work-tree=$HOME $argv; end
	# attempt to checkout files into $HOME (may need to resolve conflicts)
	dotgit checkout
	```

## Usage

Mostly, you'll only want to push **tracked** file changes

```sh
dotgitupdate # diff, prompt, add/commit/push changes
```

To start tracking new files:

```sh
dotgit add $HOME/a/path/to/my/file
```

You can also run any git command:

```sh
dotgit <normal git command>
```

## Notes

```
# important! prevents your entire HOME dir from being processed by git
dotgit config --local status.showUntrackedFiles no
```
