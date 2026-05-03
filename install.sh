#!/data/data/com.termux/files/usr/bin/bash

set -euo pipefail
IFS=$'\n\t'

# ==============================================================================
# Configuração
# ==============================================================================
if [[ -t 1 ]] && [[ "${TERM:-}" != "dumb" ]]; then
  readonly C_RESET='\033[0m'
  readonly C_INFO='\033[38;5;39m'    # azul
  readonly C_SUCCESS='\033[38;5;40m' # verde
  readonly C_WARN='\033[38;5;214m'   # laranja
  readonly C_ERROR='\033[38;5;196m'  # vermelho
else
  readonly C_RESET=''
  readonly C_INFO=''
  readonly C_SUCCESS=''
  readonly C_WARN=''
  readonly C_ERROR=''
fi

log_event() {
  local level="$1"
  local message="$2"
  local timestamp
  
  timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  local color="$C_RESET"
  local fd=1 

  case "$level" in
    INFO)    color="$C_INFO" ;;
    SUCCESS) color="$C_SUCCESS" ;;
    WARN)    color="$C_WARN" ; fd=2 ;;
    ERROR)   color="$C_ERROR"; fd=2 ;;
  esac

  printf "${color}[%s] [%-7s] %s${C_RESET}\n" "$timestamp" "$level" "$message" >&"$fd"
}

trap 'log_event "ERROR" "Interrupção algorítmica detectada. Falha fatal na linha $LINENO."' ERR

# ==============================================================================
# Execução
# ==============================================================================
log_event "INFO" "Inicializando provisionamento do ambiente Termux..."

log_event "INFO" "Sincronizando a árvore de pacotes locais..."
pkg update -y && pkg upgrade -y > /dev/null

log_event "INFO" "Compilando dependências sistêmicas e utilitários de engenharia..."
pkg install -y git zsh neovim tmux curl wget unzip zip clang cmake ninja lldb ripgrep fd fzf bat eza nodejs python > /dev/null

log_event "INFO" "Processando requisições assíncronas de repositórios (Zsh & P10k)..."
[ ! -d "$HOME/.oh-my-zsh" ] && git clone --quiet --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" &
[ ! -d "$HOME/powerlevel10k" ] && git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k" &

wait

log_event "INFO" "Alocando arquivos de configuração e reestruturando dotfiles..."
cp -r .zshrc "$HOME/"
cp -r .p10k.zsh "$HOME/"
cp -r .config "$HOME/"
cp -r .termux "$HOME/"

mkdir -p "$HOME/.termux"
echo "zsh" > "$HOME/.termux/shell"
termux-reload-settings > /dev/null 2>&1 || true

log_event "SUCCESS" "O provisionamento estrito foi concluído. Reinicie o cliente para alocação do interpretador."

