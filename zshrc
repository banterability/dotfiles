alias lsd="ls -lt"
alias pubkey="cat ~/.ssh/id_ed25519.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias psg="ps -ax | grep"

# Git
alias g=git
alias gb="git branch"
alias gc="git commit -v"
alias gcb="git checkout -b"
alias gd="git diff"
alias gs="git status"

[ -r ~/.zshrc_local ] && source ~/.zshrc_local

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
