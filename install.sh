#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "[*] atualizando sistema..." 
pkg update -y && pkg upgrade -y

echo "[*] instalando pacotes base..."
pkg install -y 
git zsh neovim tmux curl wget unzip zip 
clang cmake ninja lldb 
ripgrep fd fzf bat eza 
nodejs python

echo "[*] instalando oh-my-zsh..." [ -d "$HOME/.oh-my-zsh" ] || 
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

echo "[*] instalando powerlevel10k..." [ -d "$HOME/powerlevel10k" ] || 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

echo "[*] aplicando configs..."
cp -r .zshrc ~/ cp -r .p10k.zsh ~/ cp -r .config ~/ cp -r .termux ~/
echo "[*] ativando zsh..." 
mkdir -p ~/.termux echo "zsh" > ~/.termux/shell termux-reload-settings

echo "[✓] concluído. reinicie o Termux e rode: p10k configure"
