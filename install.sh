#!/bin/bash

# Configuration
DOTFILES_DIR=$(pwd)
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Create directories if they don't exist
mkdir -p "$CONFIG_DIR"
mkdir -p "$BACKUP_DIR"

# List of files in home directory
HOME_FILES=(".bashrc" ".zshrc" ".profile" ".bash_profile")

# List of directories/files in .config
CONFIG_ITEMS=("btop" "eza" "fastfetch" "fish" "gh" "git" "k9s" "lazydocker" "lazygit" "nvim" "starship.toml" "tmux")

# Function to symlink files
link_file() {
    local src=$1
    local dest=$2

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Backing up $dest to $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi

    echo "Linking $src -> $dest"
    ln -s "$src" "$dest"
}

# Link home files
for file in "${HOME_FILES[@]}"; do
    if [ -e "$DOTFILES_DIR/$file" ]; then
        link_file "$DOTFILES_DIR/$file" "$HOME/$file"
    fi
done

# Link config items
for item in "${CONFIG_ITEMS[@]}"; do
    if [ -e "$DOTFILES_DIR/.config/$item" ]; then
        link_file "$DOTFILES_DIR/.config/$item" "$CONFIG_DIR/$item"
    fi
done

echo "Dotfiles installation complete!"
