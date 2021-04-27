# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

PROMPT='%F{green}%m %F{blue}%~%f $ '
eval "$(direnv hook zsh)"

bindkey -v
bindkey '^R' history-incremental-search-backward

export UBER_OWNER='pawel@uber.com'

brew analytics off 2>&1 >/dev/null
export PATH=/Users/pawel/bin:$PATH

export EDITOR='vim'

export HISTFILESIZE=100000
export HISTSIZE=100000
export SAVEHIST=100000
export HISTCONTROL=ignoreboth

# Save every command before it is executed:
setopt inc_append_history
# Retrieve the history file every time history is called upon.
# setopt share_history
# Do not save duplicates in the history
setopt hist_ignore_all_dups

# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

alias cdcon="cd ~/go-code/config/infra/starlark/teams/swn"
alias cdico="cd ~/Uber/config/net/traffic"
alias cdmut="cd ~/go-code/src/code.uber.internal/rpc/muttley"
alias cdmtf="cd ~/go-code/src/code.uber.internal/rpc/mtf"
alias cdwom="cd ~/go-code/src/code.uber.internal/rpc/womf"
alias cdmco="cd ~/go-code/src/code.uber.internal/rpc/muttley-config"
alias cdobs="cd ~/go-code/src/code.uber.internal/infra/swn-observer"
alias cduns="cd ~/go-code/src/code.uber.internal/infra/uns"

alias gb="git branch"
alias gbd="git branch -D"
alias gco="git checkout"
alias gd="git diff"
alias gst="git status"
alias gsh="git show"
alias gr="git rebase"
alias gsc="git sparse-checkout"

alias zrf="source ~/dotfiles/.zshrc"
alias zshrc="vim ~/dotfiles/.zshrc"

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $HOME/gopathmodeFunc.bash

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lhG'
alias la='ls -A'
alias l='ls -CF'

alias ggrep='git grep -ni'
alias sgrep='git sgrep'
