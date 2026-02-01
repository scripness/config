#!/bin/bash
set -e

CONFIG_REPO="$HOME/Code/config"
NVIM_REPO="$HOME/Code/nvim"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

link() {
    local src="$1"
    local dest="$2"

    if [[ -L "$dest" ]]; then
        local current_target
        current_target=$(readlink "$dest")
        if [[ "$current_target" == "$src" ]]; then
            echo -e "${GREEN}✓${NC} $dest (already linked)"
            return
        else
            echo -e "${YELLOW}→${NC} $dest (relink: was $current_target)"
            rm "$dest"
        fi
    elif [[ -e "$dest" ]]; then
        echo -e "${YELLOW}!${NC} $dest exists, backing up to $dest.bak"
        mv "$dest" "$dest.bak"
    else
        echo -e "${GREEN}+${NC} $dest"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
}

verify() {
    local src="$1"
    local dest="$2"
    
    if [[ -L "$dest" ]]; then
        local current_target
        current_target=$(readlink "$dest")
        if [[ "$current_target" == "$src" ]]; then
            echo -e "${GREEN}✓${NC} $dest -> $src"
        else
            echo -e "${RED}✗${NC} $dest -> $current_target (expected $src)"
        fi
    elif [[ -e "$dest" ]]; then
        echo -e "${RED}✗${NC} $dest is a regular file (not a symlink)"
    else
        echo -e "${RED}✗${NC} $dest does not exist"
    fi
}

do_link() {
    echo "=== Symlinking configs ==="
    
    # Home root configs
    link "$CONFIG_REPO/.gitconfig" "$HOME/.gitconfig"
    
    # .config subdirectories
    link "$CONFIG_REPO/.config/amp" "$HOME/.config/amp"
    link "$CONFIG_REPO/.config/fish" "$HOME/.config/fish"
    link "$CONFIG_REPO/.config/kitty" "$HOME/.config/kitty"
    
    # Neovim (separate repo)
    link "$NVIM_REPO" "$HOME/.config/nvim"
    
    echo -e "\n${GREEN}Done!${NC}"
}

do_verify() {
    echo "=== Verifying symlinks ==="
    
    verify "$CONFIG_REPO/.gitconfig" "$HOME/.gitconfig"
    verify "$CONFIG_REPO/.config/amp" "$HOME/.config/amp"
    verify "$CONFIG_REPO/.config/fish" "$HOME/.config/fish"
    verify "$CONFIG_REPO/.config/kitty" "$HOME/.config/kitty"
    verify "$NVIM_REPO" "$HOME/.config/nvim"
}

case "${1:-link}" in
    link)   do_link ;;
    verify) do_verify ;;
    *)      echo "Usage: $0 [link|verify]"; exit 1 ;;
esac
