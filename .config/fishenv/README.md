# fishenv

directory-based environment files

⚠️ env files cannot be unsourced, so after traversing through a few directories, you need to log out the shell to explicity clear the environment

## Usage

1. save `env.fish` somewhere
1. update your `config.fish` with

   ```
   . fish.env
   ```

1. add `<id>.env` files into your `~/.config/fishenv/` directory

   fishenv will match the `id` of your files by stripping `$HOME` from `$PWD` and replacing `/` with `-`

   for example, to create an environment for `~/projects/foobar` you would create `~/.config/fishenv/projects-foobar.env`

## TODO

* make this work with fisher