# Dotfiles

## Setup

```
./install.sh
```

## Assumptions

### Required

Things won't work correctly without these.

- [`delta`](https://github.com/dandavison/delta) — set as git's pager and interactive diff filter
- [Berkeley Mono](https://berkeleygraphics.com/typefaces/berkeley-mono/) — set as the default for Ghostty and Zed
- A GPG key matching `user.signingkey` in `config/git/config`, since `commit.gpgsign` is on

### Optional

Relevant if you use the thing, but nothing will break if you don't.

- `~/.zshrc_local` will also be sourced if it exists.
- Assumes the following are available on path: `zed` (installed from the app), [`gh`](https://cli.github.com/), and [`jq`](https://jqlang.org/)
- If you plan to use [`mise`](https://mise.jdx.dev/), you'll want to add its activation script to `~/.zshrc_local`
