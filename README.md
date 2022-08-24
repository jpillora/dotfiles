# dotfiles

My configuration for:

* fish
* tmux
* ssh

Plus a some handy scripts


## Initialise

```sh
# run the restore script in this repo
curl https://jpillora.com/dotfiles/bin/restore-dotfiles | bash
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

