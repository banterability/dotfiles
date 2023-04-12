# Dotfiles

## Setup

```
ln -s ./gitconfig ~/.gitconfig
ln -s ./tmux.conf ~/.tmux.conf
ln -s ./zshrc ~/.zshrc
```

Various bits of this config also assume [`diff-so-fancy`](https://github.com/so-fancy/diff-so-fancy) and [`nvm`](https://github.com/nvm-sh/nvm) are available on the system.

## Usage

A `.zshrc_local` file in the home directory will be included, if it exists.