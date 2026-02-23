# Tobi's Dotfiles

These are my nix-darwin and home-manager configurations for my work and personal computers.

Inspirted by [kriswill/dotfiles](https://github.com/kriswill/dotfiles)

## MacOS

1. Install Homebrew:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install Determinate Nix Installer:

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate
```

3. Clone repo:

```sh
mkdir -p ~/src
git clone https://github.com/tlehman/dotfiles ~/src/dotfiles
cd ~/src/dotfiles
```

4. Move determinate's nix.conf out of the way:

```sh
sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
```

5. Install (nix-darwin)

```sh
nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .
```
