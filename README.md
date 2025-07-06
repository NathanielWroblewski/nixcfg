Nix Configuration
===

This repository contains my personal configuration for NixOS and the Nix package manager.



Updating configuration
---

After editing a configuration file, add the changes to git:
```sh
$ git add .
```

Then, from the root of this repository, rebuild nixos with:
```sh
$ sudo nixos-rebuild switch --flake ./ --show-trace
```

Keep in mind, only filetypes specified by the `.gitignore` are commited.

Commit the changes, and publish them:
```sh
$ git commit -m 'Short description of change'
$ git push origin main
```


Import tree
---

```
flake.nix
↑ ↑
│ └ deps
│   ├ imports
│   └ overlay     
└ hosts/$host/default
  ├ hosts/shared/*
  ├ hosts/$host/configuration
  │ ├ hosts/$host/hardware-configuration
  │ ├ syscfg/shared/*
  │ ├ syscfg/$host/*
  │ ├ pkgsets/global
  │ └ pkgcfg/system-level/*
  └ hosts/$host/users/default
      └ hosts/slab/users/$user
        └ home/$user/$host.nix
          └ home/$user/home.nix
            ├ pkgsets/user
            ├ pkgsets/dev
            └ pkgcfg/user-level/*
```
  
Directory Structure
---

```
.
├── constants         # expressions containing key-value pairs of constants
├── deps              # flake dependencies
│   ├── imports       # packages imported by this flake, may be nixpkgs or self-hosted
│   └── overlays      # imported package overrides
├── dotfiles          # dotfiles, e.g. .zshrc
├── flake.nix         # top-level nixos configuration entrypoint
├── home              # home-manager configuration
│   └── $user
│       ├── home.nix  # user's shared home-manager configuration
│       └── $host.nix # user's device-specific home-manager config
├── hosts
│   ├── shared        # system-level configuration shared across all hosts
│   └── $host         # system-level, device-specific configuration
│       └── users     # device-specific users
├── pkgcfg            # package configurations
│   ├── system-level  # system-level package configurations
│   └── user-level    # user-level package configurations (home-manager)
└── pkgsets           # preset package lists for users/roles
    ├── dev.nix       # developer packages
    ├── global.nix    # global packages (includes root)
    └── user.nix      # user packages
```

The canonical `configuration.nix` and `hardware-configuration.nix` provisioned by a vanilla NixOS install
is preserved and can be located in `/hosts/$host/{hardware-,}configuration.nix`.

The canonical `home.nix` is preserved and can be located in `/home/$user/home.nix`.

sops-nix
---

Sops allows you to manage SSH keys and other values in nix configuration files by first encrypting them.  It requires some additional setup.

Generate an ssh key:
```sh
$ ssh-keygen -t ed25519 -f ./id_ed25519 -C "<your>@<email>.com" 
```

Generate an encryption key from your SSH key with:
```sh
$ nix run nixpkgs#ssh-to-age -- -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt
```

Generate a public key from the age key with:
```sh
$ nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt
```

Add the public key to the `.sops.yaml` in the root of your `nixcfg` folder:
```sh
keys:
  - &primary <your public key value "age...">
creation_rules:
  - path_regex: secrets/secrets.yaml$
    key_groups:
      - age:
        - *primary
```

Then create the sops file from the root of your `nixcfg` folder:
```sh
$ nix-shell -p sops neovim --run "EDITOR=nvim sops ./secrets/sops/secrets.yaml"
```

TODO
---
- configure waybar
- configure swaylock-effects
- configure tui-greet
- configure shell
- configure editor
- unify clipboards
- use sops-nix to encrypt an SSH key
- setup themes
  - font with ligatures
  - colors / themes
- drop desktop environment
- setup remaining desktop services
- host font packages
