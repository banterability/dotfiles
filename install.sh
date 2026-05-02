#!/bin/bash
set -euo pipefail

# get the directory this script is in, regardless
# of where it's being run from
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

dim='\033[0;90m'
green='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
reset='\033[0m'

echo "### available on this system ###"

check() {
  local name="$1"
  if command -v "$name" >/dev/null 2>&1; then
    local path output version
    path="$(command -v "$name")"
    output="$("$name" --version 2>&1)"
    version="${output%%$'\n'*}"
    echo -e "  ${green}✓ ${name}${reset} ${version} ${dim}${path}${reset}"
  else
    echo -e "  ${red}✗ ${name}${reset}"
  fi
}

echo "Languages:"
check ruby
check node

echo "Tools:"
check brew
check delta
check fzf
check gh
check git
check jq
check mise
check rg
check tree
check wget
check zed

echo

echo "### dotfiles ###"

link() {
  local src="$1" dest="$2"
  local name="${dest/#$HOME/~}"
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo -e "  ${dim}${name} -> already linked${reset}"
    return
  elif [[ -L "$dest" ]]; then
    echo -e "  ${yellow}${name} -> replacing symlink to $(readlink "$dest")${reset}"
  elif [[ -e "$dest" ]]; then
    echo -e "  ${red}${name} -> regular file exists:${reset}"
    head -3 "$dest" | sed 's/^/    /'
    read -rp "  Overwrite? [y/N] " answer
    [[ "$answer" =~ ^[Yy]$ ]] || { echo "  Skipping $name"; return; }
  else
    echo -e "  ${green}${name}${reset}"
  fi
  ln -sf "$src" "$dest"
}

link "$dir/zshrc" "$HOME/.zshrc"

for src in "$dir"/config/*/*; do
  dest=~/.config/"${src#"$dir"/config/}"
  mkdir -p "$(dirname "$dest")"
  link "$src" "$dest"
done

mkdir -p ~/.claude
link "$dir/claude/CLAUDE.md" ~/.claude/CLAUDE.md

echo "Done."
