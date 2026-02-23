## ZSH initExtra

setopt interactivecomments # allow comments on the command-line
setopt AUTO_CD
# enable edit command line
autoload -U edit-command-line
zle -N edit-command-line
# Vi style
export VISUAL=nvim
bindkey -M vicmd v edit-command-line
set -o vi

# has: bash, elvish, fish, powershell, zsh
eval "$(determinate-nixd completion zsh)"

# allows brew commands
eval "$(/opt/homebrew/bin/brew shellenv)"

# local bin directory
export PATH="$HOME/.local/bin:$PATH"
