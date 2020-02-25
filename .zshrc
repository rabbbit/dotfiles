PROMPT='%F{green}%m %F{blue}%~%f $ '
eval "$(direnv hook zsh)"

bindkey -v
bindkey '^R' history-incremental-search-backward

brew analytics off 2>&1 >/dev/null
export PATH=/Users/pawel/bin:$PATH

export EDITOR='vim'

export HISTFILESIZE=100000
export HISTSIZE=100000
export SAVEHIST=100000
export HISTCONTROL=ignoreboth

setopt hist_ignore_all_dups
