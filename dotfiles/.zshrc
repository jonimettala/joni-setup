alias brewup='brew update && brew upgrade'

alias ll='ls -lahG'
alias la='ls -AG'
alias l='ls -CFG'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# nvm
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
