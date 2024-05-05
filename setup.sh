#!/bin/env bash

# Function to copy directory if it doesn't exist
copy_directory_if_not_exists() {
    local source_dir="$1"
    local dest_dir="$2"
    if [ ! -d "$dest_dir" ]; then
        echo "Copying contents of $source_dir to $dest_dir..."
        cp -r "$source_dir" "$dest_dir"
    else
        echo "Directory $dest_dir already exists, skipping..."
    fi
}

if [ -d ~/.local-terminal ]; then
    source ~/.local-terminal/.custom_bash
else
    echo "No .local-terminal directory found, cloning it from GitHub..."
    git clone https://github.com/mbaykara/.local-terminal.git ~/.local-terminal
    source ~/.local-terminal/.custom_bash
    echo "Copying git config..."
    cp ~/.local-terminal/.gitconfig ~/.gitconfig
fi

# Copy work and private directories if they don't exist
copy_directory_if_not_exists ~/.local-terminal/work ~/work
copy_directory_if_not_exists ~/.local-terminal/private ~/private
