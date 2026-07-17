# dotfiles

Cross-platform dotfiles with Termux support.

## Requirements

- Termux (F-Droid/GitHub build)
- git
- curl

## Install

```sh
pkg update && pkg upgrade -y
pkg install git curl -y

git clone https://github.com/itsryu/dotfiles.git
cd dotfiles
./install.sh
```

or

```sh
curl -fsSL https://raw.githubusercontent.com/itsryu/dotfiles/main/install.sh | bash
```

## Install packages

```sh
dots install --pkg
```

If `dots` is not found:

```sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Apply

```sh
exec -l $(which zsh)
```

## Update

```sh
cd ~/.local/share/dotfiles-main
git pull
dots install --pkg
```
````3
