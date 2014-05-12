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

function setup_rvm {
  echo "rvm use 1.9.3@${1} --create" > .rvmrc
}

# Git
alias gs="git status"
alias gb="git branch"
alias gc="git commit -v"
alias gcm="git checkout master"
alias gcb="git checkout -b"
alias gd="git diff"

# Prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo " ** "
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
export PS1='\W\[\033[1;33m\]$(parse_git_branch)\[\033[0m\]:$ '

# Ruby 1.9.3 GC
export RUBY_HEAP_MIN_SLOTS=600000
export RUBY_GC_MALLOC_LIMIT=59000000
export RUBY_HEAP_FREE_MIN=100000

# Env
export EDITOR='subl -w'
export PATH="/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:$PATH"

# RVM
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
