# dotfiles

Setup of command line tools and configs (dot files) for these tools.
Useful for fast deploy on clean Ubuntu installation.

## Install and update

```bash
wget -qO- https://raw.githubusercontent.com/dmirys/dotfiles/refs/heads/master/install.sh | bash
```

or

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/dmirys/dotfiles/master/install.sh)
```

## Uninstall

```bash
wget -qO- https://raw.githubusercontent.com/dmirys/dotfiles/refs/heads/master/install.sh | bash -s - -u
```

or

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/dmirys/dotfiles/master/install.sh) -u
```

