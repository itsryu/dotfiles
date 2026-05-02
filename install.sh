#!/data/data/com.termux/files/usr/bin/bash

# update base
pkg update -y && pkg upgrade -y

# core packages
pkg install -y git zsh neovim tmux curl wget unzip zip \
               clang cmake ninja lldb \
               ripgrep fd fzf bat eza \
               nodejs python

# install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

# install powerlevel10k
if [ ! -d "$HOME/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
fi

# apply configs
cp -r .zshrc ~/
cp -r .config ~/
cp -r .termux ~/

# set shell
mkdir -p ~/.termux
echo "zsh" > ~/.termux/shell
termux-reload-settings

echo "Setup concluído. Reinicie o Termux."
