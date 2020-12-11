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

alias cdobs="cd ~/go-code/src/code.uber.internal/infra/swn-observer"
alias cduns="cd ~/go-code/src/code.uber.internal/infra/uns"
alias cdmut="cd ~/go-code/src/code.uber.internal/rpc/muttley"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

bazel query "kind(\"$1 rule\", :*)"
