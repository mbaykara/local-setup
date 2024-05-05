#!/bin/env bash

# Function to append sourcing command to .bash_profile if it's not already there
append_to_bash_profile() {
    local bash_profile="$1"
    local sourcing_command="$2"
    if ! grep -qF "$sourcing_command" "$bash_profile"; then
        echo "$sourcing_command" >> "$bash_profile"
        echo "Added sourcing command to $bash_profile"
    else
        echo "Sourcing command already present in $bash_profile, skipping..."
    fi
}

# Function to copy directory contents if they don't exist in the destination
copy_directory_contents_if_not_exist() {
    local source_dir="$1"
    local dest_dir="$2"
    if [ ! -d "$dest_dir" ]; then
        echo "Copying contents of $source_dir to $dest_dir..."
        cp -r "$source_dir" "$dest_dir"
    else
        echo "Directory $dest_dir already exists, skipping copying contents..."
    fi
}

# Check if .local-terminal directory exists
if [ -d ~/.local-terminal ]; then
    append_to_bash_profile ~/.bash_profile "source ~/.local-terminal/.custom_bash"
else
    echo "No .local-terminal directory found, cloning it from GitHub..."
    git clone https://github.com/mbaykara/.local-terminal.git ~/.local-terminal
    append_to_bash_profile ~/.bash_profile "source ~/.local-terminal/.custom_bash"
    echo "Copying git config..."
    cp -n ~/.local-terminal/.gitconfig ~/.gitconfig  # Use -n to avoid overwriting existing file
fi

# Copy work and private directories if they don't exist
copy_directory_contents_if_not_exist ~/.local-terminal/work ~/work
copy_directory_contents_if_not_exist ~/.local-terminal/private ~/private
