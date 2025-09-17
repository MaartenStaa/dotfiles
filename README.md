# Maarten's dotfiles repo

These are my dotfiles, managed using nix/nix-darwin/nix-homebrew. At the moment,
they contain the configurations for my work and private MacBook Pro, but I may
expand them in the future for my homelab (which is currently managed
imperatively).

## Installation

Make sure this repository is cloned in `~/.dotfiles`. Some parts of the
configuration rely on this, to work around a known symlink issue (see Issues
below).

First, install Nix. I like using [nix-installer].

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate
```

Next, after sourcing the Nix shell functions or opening a new shell, run
`nix-darwin` and `home-manager` to switch the appropriate configuration:

```sh
make switch MACHINE_NAME=<name>
```

The very first time this may not work, since `nix-darwin` is not yet available.
To fix that, run it from the Nix source directly:

```sh
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .#<machine-name>
```

In this case, also check the known issues below for SSH agent caveats. After
running the above, refer to the various `make switch` commands to take care
of the Home Manager activation as well.

## Updates

### Updating Flake inputs & nvfetcher sources

```sh
make upgrade MACHINE_NAME=<name>
```

This will pull in updates, let you commit the changes, and switch to the new
configuration.

### Activating new version

After making changes to the configuration, switch to the new configuration:

```sh
make switch MACHINE_NAME=<name>
```

### Non-flake inputs

This repository uses [nv-fetcher] to manage inputs that aren't flakes. These
inputs are defined in `nvfetcher.toml`. They can be updated like this:

```sh
make update-sources
```

Note that running `make upgrade` already takes care of updating the non-flake
inputs too.

### Upgrading Nix

As mentioned in the [nix-installer] readme, you can run the following command to
the latest recommended version of Nix:

```sh
sudo -i nix upgrade-nix
```

## Home Manager versus nix-darwin

These dotfiles use both Home Manager and nix-darwin separately from each other,
mainly to work around nix-darwin requiring running with sudo, and HM not liking
this too much (possibly especially with Determinate Nix).

This means nix-darwin and its `darwin-rebuild` is used for system-level
configuration, including managing Homebrew, whereas Home Manager is used
to handle installed packages and their configurations (e.g. files under `~/.config`).

In general, `make switch` will switch both nix-darwin and Home Manager, but
they can be switched separately from each other if required:

```sh
make switch-nix-darwin MACHINE_NAME=<name>
make switch-home-manager MACHINE_NAME=<name>
```

## Uninstalling

If, for some reason, you need to uninstall Nix, you should be able to use run
`/nix/nix-installer uninstall`, assuming you've used [nix-installer] as
mentioned above.

## Issues

- The first installation might be a little rough, particularly when using the
  1Password SSH agent, for sources fetched over SSH. Running `make switch` with
  `SSH_AUTH_SOCK=<path>` set may help.

- It is currently not possible to symlink directly to a file or directory using
  `mkOutOfStoreSymlink`, as the symlink will point into the Nix store, rather
  than to `~/.dotfiles/...` as expected. As such, instead of

  ```nix
  xdg.configFile."program" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };
  ```

  You need to pass an absolute file path:

  ```nix
  xdg.configFile."program" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/program/config";
  };
  ```

[nix-installer]: https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file
[nv-fetcher]: https://github.com/berberman/nvfetcher
