# AGENTS.md - Dotfiles Repository

## Overview
Personal dotfiles/config repository for Fedora workstation. Manages symlinks from this repo to `~/.config/` and home directory.

## Commands
```bash
./setup.sh link    # Create symlinks (default)
./setup.sh verify  # Verify symlinks are correct
```

## Structure
- `.gitconfig` - Git configuration (symlinked to ~/.gitconfig)
- `.config/` - XDG config directories:
  - `amp/` - Amp AI settings and custom skills
  - `fish/` - Fish shell config, functions, plugins
  - `ghostty/` - Ghostty terminal config
  - `nvim/` - Neovim config (note: main nvim repo is at ~/Code/nvim)
  - `yazi/` - Yazi file manager config
- `setup.sh` - Symlink management script
- `todo.md` - Fedora setup checklist

## Conventions
- Shell scripts use `set -e` for strict error handling
- Symlinks point FROM this repo TO home locations
- Neovim config lives in separate repo (`~/Code/nvim`), linked via setup.sh
