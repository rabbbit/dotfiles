PROMPT='%F{green}%m %F{blue}%~%f $ '
eval "$(direnv hook zsh)"

bindkey -v
bindkey '^R' history-incremental-search-backward

brew analytics off 2>&1 >/dev/null
export PATH=/Users/pawel/bin:$PATH

export EDITOR='vim'
