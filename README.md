# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package      | Description                        |
|--------------|------------------------------------|
| `tmux`       | tmux configuration                 |
| `nvim`       | Neovim (Lazy.nvim, LSP, Telescope) |
| `opencode`   | OpenCode (plugins and MCP servers) |
| `ghostty`    | Ghostty terminal (One Dark theme)  |

## Dependencies

- [GNU Stow](https://www.gnu.org/software/stow/) (`brew install stow`)
- [Neovim](https://neovim.io/) >= 0.10
- [tmux](https://github.com/tmux/tmux)
- [Ghostty](https://ghostty.org/)
- [OpenCode](https://opencode.ai/)

## Install

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
stow tmux nvim opencode ghostty
```

## Install a single package

```bash
stow nvim
```

## Remove symlinks

```bash
stow -D nvim
```

## Reinstall (remove + apply)

```bash
stow -R nvim
```
