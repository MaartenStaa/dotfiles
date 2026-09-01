set shell := ["bash", "-euo", "pipefail", "-c"]

# Show available recipes
default:
    @just --list

# Switch the active configuration (darwin + home-manager on macOS, NixOS on Linux)
[group('switch')]
switch name:
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ "$(uname)" == "Darwin" ]]; then
        nh darwin switch . -H "{{ name }}"
        nh home switch . -c "{{ name }}"
    else
        nh os switch . -H "{{ name }}"
    fi

# Switch only the nix-darwin configuration
[group('switch')]
switch-darwin name:
    nh darwin switch . -H "{{ name }}"

# Switch only the home-manager configuration
[group('switch')]
switch-home name:
    nh home switch . -c "{{ name }}"

# Switch only the NixOS configuration
[group('switch')]
switch-os name:
    nh os switch . -H "{{ name }}"

# Upgrade: update flake inputs and non-flake sources, then switch
upgrade name: update update-sources (switch name)

# Update flake inputs
[group('maintenance')]
update:
    nix flake update

# Update non-flake sources (nvfetcher)
[group('maintenance')]
update-sources:
    nix run nixpkgs#nvfetcher

# Build the configuration without switching
check name:
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ "$(uname)" == "Darwin" ]]; then
        nh darwin build ".#{{ name }}"
        nh home build ".#{{ name }}"
    else
        nh os build ".#{{ name }}"
    fi

# Remove old generations and collect garbage
[group('maintenance')]
gc older-than="14d":
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ "$(uname)" == "Darwin" ]]; then
        sudo nix profile wipe-history \
            --older-than "{{ older-than }}" \
            --profile /nix/var/nix/profiles/system
        nix profile wipe-history \
            --older-than "{{ older-than }}" \
            --profile "$HOME/.local/state/nix/profiles/home-manager"
    else
        sudo nix profile wipe-history \
            --older-than "{{ older-than }}" \
            --profile /nix/var/nix/profiles/system
    fi
    nix store gc
    nix store optimise
