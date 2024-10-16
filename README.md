# Install

## Arch Linux Install

For new Arch installs run and chose the settings that best fit your usecase.
I recommend using minimal for the profile.

```bash
archinstall
```

Once the install is complete you should reboot into the new system as your user and run:

```note
    This script will not run as root.
```

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mhjp-coder/dotfiles/refs/heads/main/install.sh)"
```
