(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

PROMPT='%F{green}%m %F{blue}%~%f $ '

bindkey -v
bindkey '^R' history-incremental-search-backward

export UBER_OWNER='pawel@uber.com'

brew analytics off 2>&1 >/dev/null
export PATH=/Users/pawel/bin:$PATH
export PATH=/Users/pawel/go/bin:$PATH
export PATH=/Users/pawel/Uber/go-code/src/code.uber.internal/swn/scripts/:$PATH
export PATH=/Users/pawel/Uber/go-code/config/infra/starlark/scripts/:$PATH


export EDITOR='nvim'

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


alias cdico="cd ~/Uber/config/net/traffic"
alias cdgco="cd ~/Uber/go-code"
alias cdalb="cd ~/Uber/go-code/src/code.uber.internal/rpc/assistedlb"
alias cdcon="cd ~/Uber/go-code/config/infra/starlark/teams/swn"
alias cdmut="cd ~/Uber/go-code/src/code.uber.internal/rpc/muttley"
alias cdmtf="cd ~/Uber/go-code/src/code.uber.internal/rpc/mtf"
alias cdwom="cd ~/Uber/go-code/src/code.uber.internal/rpc/womf"
alias cdmco="cd ~/Uber/go-code/src/code.uber.internal/rpc/muttley-config"
alias cdobs="cd ~/Uber/go-code/src/code.uber.internal/infra/swn-observer"
alias cduns="cd ~/Uber/go-code/src/code.uber.internal/infra/uns"
alias cdaut="cd ~/Uber/go-code/src/code.uber.internal/infra/uns/net/traffic/auto-tconfig"
alias cdidl="cd ~/Uber/go-code/idl/code.uber.internal/infra/uns"
alias cdswn="cd ~/Uber/go-code/src/code.uber.internal/swn"
alias cdfa="cd ~/Uber/go-code/src/code.uber.internal/swn/fleet-analyzer"

alias gb="git branch"
alias gbd="git branch -D"
alias gco="git checkout"
alias gcm="git checkout main"
alias gd="git diff"
alias gs="git status"
alias gst="git status"
alias gsh="git show"
alias gr="git rebase"
alias grm="git rebase origin/main"
alias gsc="git sparse-checkout"

alias zrf="source ~/dotfiles/.zshrc"
alias zshrc="vim ~/dotfiles/.zshrc"

source /opt/homebrew/opt/powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# export XDG_RUNTIME_DIR="/Users/pawel/tmp"

# GOPACKAGESDRIVER=$HOME/bin/gopackagesdriver.sh
# export GOPACKAGESDRIVER

# Created by `pipx` on 2023-05-24 23:25:34
export PATH="$PATH:/Users/pawel/.local/bin"
