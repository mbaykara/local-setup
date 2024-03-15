# local-setup

Customize your terminal promt.

0. Create `~/.bash_profile` if it doesn't exist.
   
```bash
touch ~/.bash_profile
```
   
1. Clone repo to your home directory
```bash
git clone https://github.com/mbaykara/local-setup.git ~/local-setup
```

2. Append following line to `~/.bash_profile`

```bash
if [ -d ~/local-setup ]; then
   source ~/local-setup/.custom_bash
fi
```

Your promt format:

```
<username><current__working_dir><current_k8s_cluster><current_namespace><git_branch>
```

Your terminal promp will look as:

![terminal](image.png)
