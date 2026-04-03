#!/bin/bash

# Configuration
DOTFILES_DIR=$(pwd)
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Create directories if they don't exist
mkdir -p "$CONFIG_DIR"
mkdir -p "$BACKUP_DIR"

# List of files in home directory (strictly Bash)
HOME_FILES=(".bashrc" ".profile" ".bash_profile")

# List of directories/files in .config
CONFIG_ITEMS=("bash" "btop" "eza" "fastfetch" "gh" "git" "k9s" "lazydocker" "lazygit" "nvim" "starship.toml" "tmux")

# Binaries to check for
REQUIRED_BINARIES=(
    "starship"
    "btop"
    "eza"
    "fastfetch"
    "gh"
    "git"
    "k9s"
    "lazydocker"
    "lazygit"
    "nvim"
    "tmux"
    "brew"
    "k3d"
    "uv"
)

# Function to check if a command exists
check_requirements() {
    echo "Checking for required programs..."
    local missing_count=0

    for bin in "${REQUIRED_BINARIES[@]}"; do
        if ! command -v "$bin" &> /dev/null; then
            echo "⚠️  Warning: '$bin' is not installed."
            missing_count=$((missing_count + 1))
        fi
    done

    # Special check for ble.sh
    if [[ ! -s "$HOME/.local/share/blesh/ble.sh" ]]; then
        echo "⚠️  Warning: 'ble.sh' is not found in ~/.local/share/blesh/"
        missing_count=$((missing_count + 1))
    fi

    # Special check for SDKMAN!
    if [[ ! -d "$HOME/.sdkman" ]]; then
        echo "⚠️  Warning: 'SDKMAN!' is not found in ~/.sdkman"
        missing_count=$((missing_count + 1))
    fi

    if [ $missing_count -gt 0 ]; then
        echo ""
        echo "Some programs are missing. You can install most via brew:"
        echo "brew install starship btop eza fastfetch gh nvim tmux lazygit lazydocker k9s ripgrep fd fzf"
        echo ""
    else
        echo "✅ All required programs found."
    fi
}

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

# Run requirements check
check_requirements

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
