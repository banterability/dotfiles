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
alias pubkey="cat ~/.ssh/id_ed25519.pub | pbcopy && echo '=> Public key copied to pasteboard.'"
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

# Prompt

autoload -U add-zsh-hook

prompt_path() {
  local p="${PWD/#$HOME/~}"

  if [[ "$p" == "/" ]]; then
    echo "%F{cyan}/%f"
    return
  fi

  if [[ "$p" == "~" ]]; then
    echo "%F{yellow}~%f"
    return
  fi

  local -a parts=("${(@s:/:)p}")
  local len=${#parts}
  local result=""
  local start=1

  if [[ "$p" == /* ]]; then
    start=2
    result="%F{242}/%f"
  fi

  for (( i = start; i <= len; i++ )); do
    if (( i > start )); then
      result+="%F{242}/%f"
    fi
    local seg="${parts[$i]}"
    if [[ "$seg" == "~" ]]; then
      result+="%F{yellow}${seg}%f"
    elif (( i == len )); then
      result+="%F{cyan}${seg}%f"
    else
      result+="%F{blue}${seg}%f"
    fi
  done

  echo "$result"
}

git_status() {
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
      echo "%F{yellow}($branch*)%f"
    else
      echo "%F{green}($branch)%f"
    fi
  fi
}

# paths to repos with known lousy git performance
# makes branch + dirty status async
VERY_LARGE_LADS=()

_in_slow_repo() {
  local prefix
  for prefix in "${VERY_LARGE_LADS[@]}"; do
    if [[ "$PWD" == "$prefix" || "$PWD" == "$prefix"/* ]]; then
      return 0
    fi
  done
  return 1
}

GIT_STATUS=""
GIT_TMP="${TMPDIR:-/tmp}/zsh_git_$$"

_git_worker() {
  git_status > "$GIT_TMP"
  kill -USR1 $$ 2>/dev/null
}

TRAPUSR1() {
  GIT_STATUS=$(<"$GIT_TMP")
  zle && zle reset-prompt
}

_prompt_precmd() {
  local _hour=${(%):-%D{%H}}
  (( _hour >= 12 )) && _ampm=p || _ampm=a

  if _in_slow_repo; then
    GIT_STATUS="⏳"
    _git_worker &!
  else
    GIT_STATUS=$(git_status)
  fi
}

add-zsh-hook precmd _prompt_precmd

PROMPT='%K{236}%F{242} ◷ %D{%-I:%M}${_ampm} %f%k $(prompt_path) ${GIT_STATUS}
%(?.%F{green}.%F{red})>%f '

[ -r ~/.zshrc_local ] && source ~/.zshrc_local
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
