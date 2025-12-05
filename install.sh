#!/bin/bash
set -euo pipefail

echo "### dotfiles ###"

# get the directory this script is in, regardless
# of where it's being run from
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

files=(gitconfig gitignore tmux.conf zshrc)
for file in "${files[@]}"; do
  ln -sf "$dir/$file" "$HOME/.$file"
done

echo "Done."