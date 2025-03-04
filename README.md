# Dotfiles

## Setup

```
ln -s ./gitconfig ~/.gitconfig
ln -s ./gitignore ~/.gitignore
ln -s ./tmux.conf ~/.tmux.conf
ln -s ./zshrc ~/.zshrc
```

Various bits of this config assume other tools (like [`delta`](https://github.com/dandavison/delta) and [`mise`](https://mise.jdx.dev/)) are available on the system.

## Usage

A `.zshrc_local` file in the home directory will be included, if it exists.
