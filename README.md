# nix-darwin configuration

Aditya Choudhury's macOS system configuration, managed entirely by **Nix**.
Uses `nix-darwin` + `home-manager` + `nixpkgs-unstable`.

## Structure

```
flake.nix                       # Inputs + wiring (darwin, home-manager, nix-homebrew)
hosts/macbook/                  # This machine's host config
  └─ default.nix                #   imports + hostname + stateVersion
  └─ system.nix                 #   nix, shell, keyboard, fonts, system packages
  └─ gui-apps.nix               #   GUI apps from nixpkgs (chrome, vscode, slack, …)
  └─ homebrew.nix               #   nix-homebrew: only casks missing from nixpkgs
  └─ system-defaults.nix        #   macOS system defaults (dock/finder/keyboard)
modules/common/                 # System modules shared across hosts
  └─ default.nix
  └─ nix-settings.nix           #   nix.enable=false + DeterminateNix settings
  └─ users.nix                  #   user definition
home/common/                    # Home-manager config shared by all users
  └─ default.nix
  └─ zsh.nix                    #   prompt, aliases, history, direnv
  └─ git.nix                    #   git identity + ignore + gh
  └─ packages.nix               #   CLI tools (eza, zoxide, fzf, haskell, …)
home/users/aditya.c.001/        # Per-user home-manager config
  └─ default.nix                #   username + stateVersion
  └─ packages.nix               #   user-specific packages
```

## Commands

```sh
# Rebuild the system (takes effect after sudo)
sudo darwin-rebuild switch --flake ~/.nix-config#macbook

# Build only (no activation / no side effects), to check it evaluates
darwin-rebuild build --flake ~/.nix-config#macbook

# Update inputs (nixpkgs, darwin, home-manager)
nix flake update ~/.nix-config

# Apply only home-manager (skip system-level activation)
home-manager switch --flake ~/.nix-config
```

## Adding things

| What you want | Where it goes |
|---|---|
| A CLI tool | `home/common/packages.nix` → `home.packages` |
| A GUI app that exists in nixpkgs | `hosts/macbook/gui-apps.nix` → `environment.systemPackages` |
| A GUI app NOT in nixpkgs | `hosts/macbook/homebrew.nix` → `homebrew.casks` |
| macOS System Settings tweak | `hosts/macbook/system-defaults.nix` |
| A zsh alias / env var | `home/common/zsh.nix` |
| Git config | `home/common/git.nix` |
| Per-user tool | `home/users/aditya.c.001/packages.nix` |

## Notes

- **Determinate Nix** is used (`nix.enable = false`). nix-darwin's `nix.settings`
  augments `/etc/nix/nix.conf` without fighting the installer.
- **Homebrew** is still controlled by nix-homebrew for the few casks nixpkgs
  lacks — see `hosts/macbook/homebrew.nix`.
- Any dotfile Nix replaces is backed up to `*.backup` (`backupFileExtension`).
- Git identity set to `achoudhury2004@gmail.com` (GitHub). Work repos can use
  `aditya.c.001@juspay.in` via `conditionalIncludes` in `home/common/git.nix`.