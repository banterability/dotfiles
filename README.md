# Dotfiles

Configuration for frequently used apps & tools.

## Usage

Running `./install.sh` symlinks config files from this repo into their expected locations. It's safe to re-run; you'll be prompted before any existing non-symlink file gets overwritten.

It also outputs information about other binaries available on the system, along with their versions and paths:

<img width="206" height="292" alt="Screenshot 2026-05-01 at 11 34 43 PM" src="https://github.com/user-attachments/assets/a7ccbfaa-4d5e-437f-bec1-8f86fe915153" />

Installing any desired missing tools is an exercise for the reader.

## Required

Things won't work correctly without these extra bits:

- [`delta`](https://github.com/dandavison/delta) — set as git's pager and interactive diff filter
- [Berkeley Mono](https://berkeleygraphics.com/typefaces/berkeley-mono/) — set as the default for Ghostty and Zed
- A GPG key matching `user.signingkey` in `config/git/config`, since `commit.gpgsign` is on

## Other Considerations

- `~/.zshrc_local` will also be sourced if it exists.
- If you plan to use [`mise`](https://mise.jdx.dev/), you'll want to add its activation script to `~/.zshrc_local`
