#!/bin/env bash

# Function to check if directory exists and copy contents if it does
copy_directory_if_exists() {
    local source_dir="$1"
    local dest_dir="$2"
    if [ -d "$source_dir" ]; then
        echo "Copying contents of $source_dir to $dest_dir..."
        cp -r "$source_dir"/* "$dest_dir"
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
    echo "Checking and copying work and private directories..."
    copy_directory_if_exists ~/.local-terminal/work ~/work
    copy_directory_if_exists ~/.local-terminal/private ~/private
fi
