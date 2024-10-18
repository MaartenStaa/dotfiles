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
  };

  outputs =
    {
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
        work-mbp = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./machines/work-mbp
            home-manager.darwinModules.home-manager
            {
              home-manager.backupFileExtension = "backup";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."maartens" = {
                imports = [
                  ./modules/home.nix
                  ./modules/darwin.nix
                  ./modules/pkgs.nix
                  ./modules/fzf.nix
                  ./modules/fd
                  ./modules/tmux
                  ./modules/neovim
                  ./modules/git
                  ./modules/shell.nix
                  ./modules/kitty
                  ./modules/karabiner
                  catppuccin.homeManagerModules.catppuccin
                ];
              };
            }
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                user = "maartens";
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
        private-mbp = {
          system = "x86_64-darwin";
          nixpkgs.hostPlatform = "x86_64-darwin";
          modules = [
            ./machines/private-mbp
            home-manager.nixosModules.home-manager
            {
              home-manager.backupFileExtension = "backup";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.maarten = {
                imports = [
                  ./modules/home.nix
                  ./modules/darwin.nix
                  ./modules/pkgs.nix
                  ./modules/fzf.nix
                  ./modules/fd
                  ./modules/tmux
                  ./modules/neovim
                  ./modules/git
                  ./modules/shell.nix
                  ./modules/kitty
                  ./modules/karabiner
                  catppuccin.homeManagerModules.catppuccin
                ];
              };
            }
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                user = "maartens";
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
