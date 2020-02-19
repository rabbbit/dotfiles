PROMPT='%F{blue}%~%f $ '
eval "$(direnv hook zsh)"

bindkey -v
bindkey '^R' history-incremental-search-backward
