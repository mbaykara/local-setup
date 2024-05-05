#!/bin/bash
if [ -d ~/.local-terminal ]; then
    source ~/.local-terminal/.custom_bash
else
    echo "No .local-terminal directory found, cloning it from GitHub..."
    git clone https://github.com/mbaykara/local-terminal.git ~/.local-terminal
    source ~/.local-terminal/.custom_bash
    echo "Copying git config..."
    cp ~/.local-terminal/.gitconfig ~/.gitconfig
    mv ~/.local-terminal/work ~/work
    mv ~/.local-terminal/private ~/private
fi
