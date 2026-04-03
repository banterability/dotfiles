#!/bin/bash
set -euo pipefail

echo "### dotfiles ###"

# get the directory this script is in, regardless
# of where it's being run from
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

dim='\033[0;90m'
green='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
reset='\033[0m'

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

files=(gitconfig gitignore tmux.conf zshrc)
for file in "${files[@]}"; do
  link "$dir/$file" "$HOME/.$file"
done

mkdir -p ~/.config/ghostty
link "$dir/config/ghostty/config" ~/.config/ghostty/config

mkdir -p ~/.config/zed
link "$dir/config/zed/settings.json" ~/.config/zed/settings.json

mkdir -p ~/.claude
link "$dir/claude/CLAUDE.md" ~/.claude/CLAUDE.md

echo "Done."
