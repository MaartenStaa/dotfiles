{
  description = "Maarten's macOS Flakes with nix-darwin and home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    catppuccin.url = "github:catppuccin/nix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";

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
    {
      darwinConfigurations = {
        work-mbp =
          let
            args = {
              username = "maartens";
              email = "maartens@spotify.com";
            };
            system = "aarch64-darwin";
            pkgs = import nixpkgs {
              inherit system;
            };
            fetchers = {
              inherit (pkgs)
                fetchgit
                fetchurl
                fetchFromGitHub
                dockerTools
                ;
            };
            _sources = import ./_sources/generated.nix fetchers;
          in
          nix-darwin.lib.darwinSystem {
            system = system;
            specialArgs = args;
            modules = with args; [
              ./machines/work-mbp
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  backupFileExtension = "backup";
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    inherit username email inputs;
                  };
                  users.${username} = {
                    imports = [
                      ./modules/home.nix
                      ./modules/darwin.nix
                      ./modules/pkgs.nix
                      ./modules/development.nix
                      ./modules/fzf.nix
                      ./modules/fd
                      ./modules/tmux
                      ./modules/neovim
                      ./modules/asdf
                      ./modules/git
                      ./modules/shell.nix
                      ./modules/kitty
                      ./modules/karabiner
                      ./modules/bazel.nix
                      ./modules/gcloud.nix
                      ./modules/python.nix
                      catppuccin.homeModules.catppuccin
                    ];
                  };
                };
              }
              ./modules/darwin-apps.nix
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
            ];
          };
        private-mbp =
          let
            args = {
              username = "maarten";
              email = "maarten@staa.dev";
            };
          in
          nix-darwin.lib.darwinSystem {
            system = "x86_64-darwin";
            nixpkgs.hostPlatform = "x86_64-darwin";
            specialArgs = args;
            modules = with args; [
              ./machines/private-mbp
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  backupFileExtension = "backup";
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    inherit username email inputs;
                  };
                  users.${username} = {
                    imports = [
                      ./modules/home.nix
                      ./modules/darwin.nix
                      ./modules/pkgs.nix
                      ./modules/development.nix
                      ./modules/fzf.nix
                      ./modules/fd
                      ./modules/tmux
                      ./modules/neovim
                      ./modules/asdf
                      ./modules/git
                      ./modules/shell.nix
                      ./modules/kitty
                      ./modules/karabiner
                      ./modules/python.nix
                      catppuccin.homeModules.catppuccin
                    ];
                  };
                };
              }
              ./modules/darwin-apps.nix
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
            ];
          };
      };

      formatter = {
        aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
      };
    };
}
