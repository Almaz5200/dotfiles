# Dotfiles

This repository contains my public dotfiles. Some parts containing sensitive information have been omitted, such as SSH keys (even though they are encrypted), the ﻿known_hosts file, and a repo list.
To install [chezmoi](https://www.chezmoi.io/) and apply the dotfiles, use the following command:

```bash
GITHUB_USERNAME=almaz5200
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:$GITHUB_USERNAME/dotfiles.git
```

However, it wouldn't work properly due to some of my privates missing, so it's best if you work the repo and modify it to your needs.
