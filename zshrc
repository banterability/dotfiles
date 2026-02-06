autoload -U compinit
compinit

autoload -U colors
colors

setopt PROMPT_SUBST

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LOCALE="en_US.UTF-8"

autoload edit-command-line
zle -N edit-command-line
bindkey '^X^e' edit-command-line

# Control+U deletes all characters before the cursor
bindkey '^u' backward-kill-line

# Control+W deletes a whole word backwards, stopping at forward slashes (https://unix.stackexchange.com/a/250700)
my-backward-kill-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-kill-word
}
zle -N my-backward-kill-word
bindkey '^W' my-backward-kill-word

alias lsd="ls -lt"
alias npm-publish-preview="npm pack && tar -xvzf *.tgz && rm -rf package *.tgz"
alias pubkey="cat ~/.ssh/id_ed25519.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias psg="ps -ax | grep"

# Git
g () {
  git "$@"
}

alias gb="git branch"
alias gc="git commit -v"
alias gc!='git commit -v --amend'
alias gcb="git checkout -b"
alias gd="git diff"
alias gs="git status"

[ -r ~/.zshrc_local ] && source ~/.zshrc_local
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
