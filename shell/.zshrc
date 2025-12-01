# Oh My Zsh settings
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Set default editor
export EDITOR=nvim

# Source local secrets (API keys, SSH passwords, etc.)
# This file should NEVER be committed to git
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

# Default command for FZF (ripgrep)
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'

# Set ZSH theme
ZSH_THEME="half-life"

# Set BAT theme
export BAT_THEME=base16

# Hyphen insensitive option
HYPHEN_INSENSITIVE="true"

# Disable colors in Neovim terminal
if [[ -n "$NVIM" ]]; then
  export NO_COLOR=1
  export CLICOLOR=0
  export CLICOLOR_FORCE=0
  unset LS_COLORS
  unset EZA_COLORS
fi

# Plugins
# Enable Git, syntax highlighting, and autosuggestions plugins
# Disable syntax highlighting in Neovim terminal
if [[ -n "$NVIM" ]]; then
  plugins=(git zsh-autosuggestions)
else
  plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
fi

# Source Oh My Zsh configuration
source $ZSH/oh-my-zsh.sh

# Load pywal colors for st on shell startup
if [[ "$TERM" == "st-256color" ]] && [[ -f ~/.st-init ]]; then
  source ~/.st-init
fi


# Open Obsidian notes in nvim
notes() {
  cd ~/Documents/Obsidian/brain2/
  nvim
}

# Create a new tmux session and run 'fum'
monk() {
  tmux new-session -d -x- -y- \; send-keys 'fum' C-m \;
}

# Alias cat -> bat
alias cat="bat"

# Alias for ueberzug -> ueberzug++
alias ueberzug="ueberzugpp"

# Alias for find -> fd
alias find="fd"
# Alias for bacon and nextest
alias ntest="bacon nextest"

# Alias for grep -> rga 
alias grep="rga"

# Alias for du -> dust
alias du="dust"

# Alias for finding external storage.
alias usb="cd /run/media/croc/"
# Alias vi for nvim
alias vi="nvim"

# Custom alias for 'ls' with eza
if [[ -n "$NVIM" ]]; then
  alias ls="eza --color=never --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
else
  alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
fi

# Use z for cd
alias cd="z"

# Alias for attaching to tmux session
alias ta="tmux a"

# Alias for lazygit
alias lg="lazygit"

# Alias for recording with wf-recorder
alias rec="wf-recorder -f ~/Videos/temprecording.webm"

# Alias for ani-cli
alias watch="ani-cli"

# Alias for ssh (password stored in .zshrc.local)
alias jjkvcont="sshpass -p $JJKVCONT_PASSWORD ssh root@robserver.hopto.org -p24"

alias ssh="kitty +kitten ssh"

# Function to juggle tmux windows (needs improvement for clarity)
juggle() {
  if [ "$1" = "it" ]; then
    shift        # eat the 'update'
    tmux new-session \; send-keys 'notes' C-m \; split-window -h -p 15 \; split-window -v -l 15 \; send-keys 'ncspot' C-m \;
  elif [ "$1" = "fruit" ]; then
    tmux new-session \; send-keys 'fo' C-m \; split-window -h -p 15 \; split-window -v -l 15 \; send-keys 'ncspot' C-m \;
  else
    command echo "What do you want to juggle?"
  fi
}

# FZF configuration

# Function to open files with fzf and bat preview
fo() { fzf -m --preview='bat --color=always {}' --bind 'enter:become(nvim {+})'; }

# Function to run fzf with different previews based on command
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)               fzf --preview 'eza --tree --colour=always {} | head -200' "$@" ;;
    export|unset)     fzf --preview "eval 'echo \$' {}" "$@" ;;
    ssh)            fzf --preview 'dig {}' "$@" ;;
    *)              fzf --preview "--preview 'bat -n --colour=always --line-range :500 {}'" "$@" ;;
  esac
}

# FZF default options for enhanced appearance
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#000000
--color=hl:#5f8787,hl+:#888888,info:#99bbaa,marker:#99bbaa
--color=prompt:#999999,spinner:#ddeecc,pointer:#ddeecc,header:#87afaf
--color=border:#444444,preview-fg:#c1c1c1,label:#aeaeae,query:#d9d9d9
--border="rounded" --border-label="fo™ Search Technology" --border-label-pos="0" --preview-window="border-rounded"
--margin="1" --prompt="λ " --marker="* " --pointer=">"
--separator="_" --scrollbar="|"'

# Default command for FZF (fd)
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

# Function to search and install pacman packages using fzf
fzfman() {
  packages="$(awk {'print $1'} <<< $(pacman -Ss $1 | awk 'NR%2 {printf "\033[1;32m%s \033[0;36m%s\033[0m — ",$1,$2;next;}{ print substr($0, 5, length($0) - 4); }' | fzf -m --ansi --select-1))"
  [ "$packages" ] && sudo pacman -S $(echo "$packages" | tr "\n" " ")
}

# Custom functions

# Function to use yazi with temporary cwd file
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Path additions (pipx and tmuxifier)
# Created by `pipx` on 2024-12-20 04:50:48
export PATH="$PATH:/home/croc/.local/bin"
# export PATH="$HOME/.tmuxifier/bin:$PATH"

export PATH="$PATH:/home/croc/.config/emacs/bin"

# Enable fzf and zoxide (thefuck moved to lazy load)
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
unset PYTHONPATH

# Lazy load thefuck (only when invoked)
thefuck() {
  eval $(command thefuck --alias)
  thefuck "$@"
}

# Lazy load NVM (only when invoked)
nvm() {
  unset -f nvm
  source /usr/share/nvm/init-nvm.sh
  nvm "$@"
}

node() {
  unset -f node
  source /usr/share/nvm/init-nvm.sh
  node "$@"
}

npm() {
  unset -f npm
  source /usr/share/nvm/init-nvm.sh
  npm "$@"
}



export PATH="$PATH:/home/croc/.npm-global/bin"

# opencode
export PATH=/home/croc/.opencode/bin:$PATH

# Initialize Starship prompt
eval "$(~/.local/bin/starship init zsh)"


# System tools (jdtls, etc.) use Java 21
export PATH=$JAVA_HOME/bin:$PATH

# Your project uses Java 17
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
