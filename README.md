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
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Next, after sourcing the Nix shell functions or opening a new shell, run
`nix-darwin` to switch the appropriate configuration:

```sh
nix run nix-darwin -- switch --flake ~/.dotfiles/#<machine-name>
```

## Updates

### Updating Flake inputs

```sh
nix flake update
```

Make sure to commit the changes to `flake.lock`.

### Activating new version

After updating Flake inputs, or making changes to the configuration, switch to
the new configuration using `darwin-rebuild`:

```sh
darwin-rebuild switch --flake ~/.dotfiles/#<machine-name>
```

### Upgrading Nix

As mentioned in the [nix-installer] readme, you can run the following command to
the latest recommended version of Nix:

```sh
sudo -i nix upgrade-nix
```

## Uninstalling

If, for some reason, you need to uninstall Nix, you should be able to use run
`/nix/nix-installer uninstall`, assuming you've used [nix-installer] as
mentioned above.

## Issues

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
