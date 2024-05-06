# .local-setup :rocket: :trident:

This repository allow you to setup your local environment in 1 minute.


## Features
:white_check_mark: Generate key pairs for work and private usage respectively under `~/.ssh/work/` and `~/.ssh/private/`.

:white_check_mark: Manage your Git configuration file so that you can have distinct SSH keys for different directories, such as `work` and `private`, to avoid accidentally committing with the wrong user.

:white_check_mark: Manage your aliases.

:white_check_mark: Customize your terminal prompt.

## Invoke the setup script, it will set your environment up and running in few seconds!

```bash
curl -fsSL https://raw.githubusercontent.com/mbaykara/.local-terminal/main/setup.sh | bash
```

Done!


Your terminal promp will look as:
```
<username><current__working_dir><current_k8s_cluster><current_namespace><git_branch>
```
![terminal](image.png)

Feel free to fork and customize it for yourself! 
