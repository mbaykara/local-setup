#!/usr/bin/env bash

TOOL_LIST="kubectl kubectx helm fluxctl k9s fzf"
# Function to install tools
install_tools() {
    local tool_list="$1"
    for tool in $tool_list; do
        if ! command -v "$tool" &> /dev/null; then
            echo "Installing $tool..."
            case "$tool" in
            kubectl)
                echo "Installing kubectl..."
                brew install kubectl
                ;;
            kubectx)
                echo "Installing kubectx..."
                brew install kubectx
                ;;
            helm)
                echo "Installing helm..."
                brew install helm
                ;;
            fluxctl)
                echo "Installing fluxctl..."
                brew install fluxcd/tap/flux
                ;;
            k9s)
                echo "Installing k9s..."
                brew install k9s
                ;;
            fzf)
                echo "Installing fzf..."
                brew install fzf
                ;;
            *)
                echo "Unknown tool: $tool"
                ;;
            esac
        else
            echo "$tool is already installed, skipping..."
        fi
    done
}

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

#Generate ssh-key pairs
WORK_SSH_DIR="$HOME/.ssh/work"
PRIVATE_SSH_DIR="$HOME/.ssh/private"
WORK_KEY_NAME="id_ed25519_work"
PRIVATE_KEY_NAME="id_ed25519_private"
DIR_PERMISSIONS=700
generate_key_pair() {
    local key_dir=$1
    local key_name=$2
    if [ ! -d "$key_dir" ]; then
        mkdir -p "$key_dir"
    fi
    if [ ! -f "$key_dir/$key_name" ]; then
        ssh-keygen -t ed25519 -N "" -f "$key_dir/$key_name"
        echo "SSH key pair generated in $key_dir."
        ssh-add "$key_dir/$key_name"
        echo "SSH key added to SSH agent."
    else
        echo "SSH key pair already exists in $key_dir."
        ssh-add -l | grep "$key_dir/$key_name" > /dev/null
        if [ $? -ne 0 ]; then
            ssh-add "$key_dir/$key_name"
            echo "SSH key added to SSH agent."
        else
            echo "SSH key already added to SSH agent."
        fi
    fi
}


# Install tools
install_tools "$TOOL_LIST"
# Generate SSH key pairs
generate_key_pair "$WORK_SSH_DIR" "$WORK_KEY_NAME"
generate_key_pair "$PRIVATE_SSH_DIR" "$PRIVATE_KEY_NAME"
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
# Iterate all private keys and add to SSH agent
for private_key in $(find ~/.ssh -type f ! -name "*.pub"); do
    if [ -f "$private_key" ]; then
        ssh-add "$private_key"
        echo "Added $private_key to SSH agent."
    fi
    chmod -R $DIR_PERMISSIONS ~/.ssh
done
