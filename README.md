# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package      | Description                        |
|--------------|------------------------------------|
| `tmux`       | tmux configuration                 |
| `nvim`       | Neovim (Lazy.nvim, LSP, Telescope) |
| `opencode`   | OpenCode (plugins and MCP servers) |
| `git`        | Git configuration and global ignore |
| `beets`      | Beets music library manager        |
| `ghostty`    | Ghostty terminal (One Dark theme)  |
| `mise`       | mise-en-place tool manager         |
| `zed`        | Zed editor settings                |
| `zsh`        | Zsh shell configuration            |

## Dependencies

- [GNU Stow](https://www.gnu.org/software/stow/) (`brew install stow`)
- [Git](https://git-scm.com/)
- [Neovim](https://neovim.io/) >= 0.10
- [tmux](https://github.com/tmux/tmux)
- [Ghostty](https://ghostty.org/)
- [Beets](https://beets.io/)
- [OpenCode](https://opencode.ai/)
- [mise](https://mise.jdx.dev/)
- [Zed](https://zed.dev/)
- [Zsh](https://www.zsh.org/)

## Install

```bash
git clone git@github.com:skhaz/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow tmux nvim opencode beets ghostty git mise zed zsh
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
