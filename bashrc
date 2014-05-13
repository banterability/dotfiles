# Include servers (not under source control)
source "$HOME/.servers"

# Shortcuts
alias c="script/console"
alias s="subl ."
alias o="open ."
alias lsd="ls -lt"

alias pubkey="cat ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias http='python -m SimpleHTTPServer'

alias monitor="sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --disassociate"

# Editors
export EDITOR='subl -w'
alias m="mate ."
alias s="subl ."
alias a="atom ."

alias o="open ."
alias lsd="ls -lt"
alias psg="ps -ax | grep"

# Git
alias gs="git status"
alias gb="git branch"
alias gc="git commit -v"
alias gcm="git checkout master"
alias gcb="git checkout -b"
alias gd="git diff"
alias ggrep="git rev-list --all | xargs git grep"

alias http='python -m SimpleHTTPServer'

# Prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo " ** "
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
export PS1='\W\[\033[1;33m\]$(parse_git_branch)\[\033[0m\]:$ '

# Env
export PATH="/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:$PATH"
