echo >> /Users/tobi.lehman/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(direnv hook zsh)"
export EDITOR=nvim
alias vi=nvim
alias vim=nvim

y () {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")"  && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]
	then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
if [[ $options[zle] = on ]]; then
  eval "$(fzf --zsh)"
fi
eval "$(zoxide init zsh)"

# tat: tmux attach
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}
