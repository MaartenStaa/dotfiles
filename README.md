# Maarten's dotfiles repo

These are my dotfiles, managed using Nix, nix-darwin, and nix-homebrew. They
contain configurations for my work MacBook Pro, personal MacBook Pro, and
desktop PC (NixOS).

## Configuration names

| Name | Platform | Description |
|------|----------|-------------|
| `work-mbp` | macOS (aarch64) | Work MacBook Pro |
| `personal-mbp` | macOS (x86_64) | Personal MacBook Pro |
| `maarten-pc` | NixOS (x86_64) | Desktop PC |

## First-time setup

Clone this repository to `~/.dotfiles`:

```sh
git clone <repo> ~/.dotfiles
cd ~/.dotfiles
```

Install Nix using [nix-installer]:

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate
```

On first install, `just` and `nh` aren't available yet. Bootstrap using the
underlying tools directly:

### macOS

```sh
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .#<name>
nix run nixpkgs#home-manager -- switch --flake .#<name>
```

### NixOS

```sh
sudo nixos-rebuild switch --flake .#<name>
```

After the first switch, `just` and `nh` are installed and all further operations
use the recipes below.

See [Known issues](#known-issues) for SSH agent caveats on first install.

## Usage

### Switching configurations

After making changes, switch to the new configuration:

```sh
just switch <name>
```

On macOS this switches both nix-darwin and home-manager. On NixOS it switches
the full system (including home-manager as a NixOS module).

To switch components individually on macOS:

```sh
just switch-darwin <name>
just switch-home <name>
```

### Upgrading

Update all flake inputs, non-flake sources, and switch:

```sh
just upgrade <name>
```

Or update inputs without switching:

```sh
just update          # flake inputs
just update-sources  # nvfetcher sources
```

### Building without switching

```sh
just check <name>
```

### Garbage collection

```sh
just gc                    # default: 14 days
just gc older-than=30d     # custom threshold
```

### Upgrading Nix itself

```sh
sudo -i nix upgrade-nix
```

## Home Manager versus nix-darwin

These dotfiles use both Home Manager and nix-darwin separately on macOS,
mainly because nix-darwin requires sudo while Home Manager doesn't play well
with it (especially with Determinate Nix).

nix-darwin handles system-level configuration including Homebrew, while
Home Manager handles user packages and their configurations (e.g. `~/.config`).

On NixOS, Home Manager is integrated as a NixOS module, so `just switch`
handles everything in one step.

## Non-flake inputs

This repository uses [nvfetcher] to manage inputs that aren't flakes, defined
in `nvfetcher.toml`. Running `just upgrade` takes care of updating these
alongside flake inputs.

## Uninstalling

If using [nix-installer]:

```sh
/nix/nix-installer uninstall
```

## Known issues

- First install with 1Password SSH agent may require setting `SSH_AUTH_SOCK`
  explicitly for sources fetched over SSH.

- `mkOutOfStoreSymlink` requires absolute paths. Instead of:

  ```nix
  xdg.configFile."program".source = config.lib.file.mkOutOfStoreSymlink ./config;
  ```

  Use:

  ```nix
  xdg.configFile."program".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/.dotfiles/modules/program/config";
  ```

[nix-installer]: https://github.com/DeterminateSystems/nix-installer
[nvfetcher]: https://github.com/berberman/nvfetcher
