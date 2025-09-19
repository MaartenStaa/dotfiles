{
  description = "Maarten's macOS Flakes with nix-darwin and home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Homebrew taps
    tap-homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    tap-homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    tap-homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    tap-nikitabobko-tap = {
      url = "github:nikitabobko/homebrew-tap";
      flake = false;
    };

    # Fish plugins
    fish-plugin-nvm = {
      url = "github:jorgebucaran/nvm.fish";
      flake = false;
    };

    # ASDF version manager plugins
    asdf-plugin-python = {
      url = "github:danhper/asdf-python";
      flake = false;
    };
    asdf-plugin-nodejs = {
      url = "github:asdf-vm/asdf-nodejs";
      flake = false;
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      catppuccin,
      home-manager,
      nix-darwin,
      nix-homebrew,
      tap-homebrew-core,
      tap-homebrew-cask,
      tap-homebrew-bundle,
      tap-nikitabobko-tap,
      ...
    }:
    let
      work = {
        username = "maartens";
        email = "maartens@spotify.com";
        arch = "aarch64-darwin";
      };
      personal = {
        username = "maarten";
        email = "maarten@staa.dev";
        arch = "x86_64-darwin";
      };
    in
    {
      darwinConfigurations = with work; {
        work-mbp =
          let
            args = {
              username = username;
              email = email;
            };
            system = arch;
            pkgs = import nixpkgs {
              inherit system;
            };
            sshAgentSock = builtins.getEnv "SSH_AUTH_SOCK";
            fetchers = {
              inherit (pkgs)
                fetchurl
                fetchFromGitHub
                dockerTools
                ;
              fetchgit =
                args:
                (pkgs.fetchgit args).overrideAttrs (_: {
                  GIT_SSH_COMMAND = "${pkgs.openssh}/bin/ssh -o IdentityAgent=\"${sshAgentSock}\" -o StrictHostKeyChecking=accept-new -vvv";
                });
            };
            _sources = import ./_sources/generated.nix fetchers;
          in
          nix-darwin.lib.darwinSystem {
            system = system;
            specialArgs = args;
            modules = with args; [
              nix-homebrew.darwinModules.nix-homebrew

              {
                nix-homebrew = {
                  enable = true;
                  user = username;
                  taps = {
                    "homebrew/homebrew-core" = tap-homebrew-core;
                    "homebrew/homebrew-cask" = tap-homebrew-cask;
                    "homebrew/homebrew-bundle" = tap-homebrew-bundle;
                    "nikitabobko/homebrew-tap" = tap-nikitabobko-tap;
                    "spotify/homebrew-sptaps" = _sources.spotify-homebrew-sptaps.src;
                  };
                  mutableTaps = false;
                };
              }

              ./machines/work-mbp
              ./modules/nix-darwin/determinate.nix
              ./modules/nix-darwin/homebrew.nix
              ./modules/nix-darwin/pkgs.nix
              ./modules/shared/config.nix
            ];
          };
        private-mbp =
          with personal;
          nix-darwin.lib.darwinSystem {
            system = arch;
            nixpkgs.hostPlatform = arch;
            specialArgs = args;
            modules = with args; [
              nix-homebrew.darwinModules.nix-homebrew

              {
                nix-homebrew = {
                  enable = true;
                  user = username;
                  taps = {
                    "homebrew/homebrew-core" = tap-homebrew-core;
                    "homebrew/homebrew-cask" = tap-homebrew-cask;
                    "homebrew/homebrew-bundle" = tap-homebrew-bundle;
                    "nikitabobko/homebrew-tap" = tap-nikitabobko-tap;
                  };
                  mutableTaps = false;
                };
              }

              ./machines/private-mbp
              ./modules/nix-darwin/determinate.nix
              ./modules/nix-darwin/homebrew.nix
              ./modules/nix-darwin/pkgs.nix
              ./modules/shared/config.nix
            ];
          };
      };

      homeConfigurations = {
        work-mbp =
          with work;
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages."${arch}";
            extraSpecialArgs = {
              inherit username email inputs;
            };
            modules = [
              ./modules/shared/config.nix

              ./modules/home-manager/asdf
              ./modules/home-manager/bazel.nix
              ./modules/home-manager/darwin.nix
              ./modules/home-manager/development.nix
              ./modules/home-manager/fd
              ./modules/home-manager/fzf.nix
              ./modules/home-manager/gcloud.nix
              ./modules/home-manager/ghostty
              ./modules/home-manager/git
              ./modules/home-manager/home.nix
              ./modules/home-manager/karabiner
              ./modules/home-manager/kitty
              ./modules/home-manager/macos-apps.nix
              ./modules/home-manager/neovim
              ./modules/home-manager/pkgs.nix
              ./modules/home-manager/python.nix
              ./modules/home-manager/shell.nix
              ./modules/home-manager/tmux
              ./modules/home-manager/zed

              catppuccin.homeModules.catppuccin
            ];
          };

        private-mbp =
          with personal;
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages."${arch}";
            extraSpecialArgs = {
              inherit username email inputs;
            };
            modules = [
              ./modules/shared/config.nix

              ./modules/home-manager/home.nix
              ./modules/home-manager/darwin.nix
              ./modules/home-manager/pkgs.nix
              ./modules/home-manager/development.nix
              ./modules/home-manager/fzf.nix
              ./modules/home-manager/fd
              ./modules/home-manager/tmux
              ./modules/home-manager/neovim
              ./modules/home-manager/asdf
              ./modules/home-manager/git
              ./modules/home-manager/shell.nix
              ./modules/home-manager/kitty
              ./modules/home-manager/macos-apps.nix
              ./modules/home-manager/ghostty
              ./modules/home-manager/karabiner
              ./modules/home-manager/python.nix
              ./modules/home-manager/zed

              catppuccin.homeModules.catppuccin
            ];
          };
      };

      formatter = {
        aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
      };
    };
}
