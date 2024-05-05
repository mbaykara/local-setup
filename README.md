# .local-setup

This repository allow you to setup your local environment in 1 minute.


## Features
- [ ] Manage your Git configuration file so that you can have distinct SSH keys for different directories, such as `work` and `private`, to avoid accidentally committing with the wrong user.
- [ ] Manage your aliases.
- [ ] Customize your terminal prompt.

1. Invoke the init.sh script, it will set your environment up and running!

   ```bash
   curl -fsSL https://raw.githubusercontent.com/mbaykara/.local-terminal/main/init.sh | bash
   ```

Your promt format:

```
<username><current__working_dir><current_k8s_cluster><current_namespace><git_branch>
```

Your terminal promp will look as:

![terminal](image.png)
