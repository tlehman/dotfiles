# Tobi's dotfiles

Make `~/.zshrc` a symlink to `config/zsh/zshrc`, 
and more generally, make `~/.config` a symlink to this 
repo.

## The [`nix/`](./nix) directory

This contains some useful nix programs to do things like Python dependency management using the nix package manager.

To use python-shell.nix file, run:

```sh
nix-shell nix/python-shell.nix
```

## Dependencies

See [tools.txt](./tools.txt)

