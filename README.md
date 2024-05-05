# local-setup

Customize your terminal promt.

1. Create `~/.bash_profile` if it doesn't exist.

```bash
touch ~/.bash_profile
```

2. Append following line to `~/.bash_profile`

```bash
if [ -d ~/.local-terminal ]; then
   source ~/.local-terminal/.custom_bash
else
   echo "No .local-terminal directory found, cloning it from GitHub..."
   git clone https://github.com/mbaykara/local-terminal.git ~/.local-terminal
   source ~/.local-terminal/.custom_bash
   echo "Copying git config..."
   cp ~/.local-terminal/.gitconfig ~/.gitconfig
   mv ~/.local-terminal/work ~/work
   mv ~/~/.local-terminal/private ~/private
fi
```

Your promt format:

```
<username><current__working_dir><current_k8s_cluster><current_namespace><git_branch>
```

Your terminal promp will look as:

![terminal](image.png)
