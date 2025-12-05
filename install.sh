#!/bin/bash
set -euo pipefail

echo "### dotfiles ###"

# get the directory this script is in, regardless
# of where it's being run from
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

files=(gitconfig gitignore tmux.conf zshrc)
for file in "${files[@]}"; do
  echo "Linking .$file..."
  ln -sf "$dir/$file" "$HOME/.$file"
done

echo "Linking .config/ghostty/config..."
mkdir -p ~/.config/ghostty
ln -sf "$dir/ghostty/config" ~/.config/ghostty/config

echo "Linking .claude..."
mkdir -p ~/.claude
ln -sf "$dir/claude/CLAUDE.md" ~/.claude/CLAUDE.md
# ln -sf "$dir/claude/commands" ~/.claude

echo "Done."
