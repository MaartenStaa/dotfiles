{
  description = "Maarten's Nix Flakes with nix-darwin, NixOS, and home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    oyui = {
      url = "github:emilien-jegou/oyui";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    # Homebrew taps
    tap-asheshgoplani-tap = {
      url = "github:asheshgoplani/homebrew-tap";
      flake = false;
    };
    tap-homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    tap-homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    tap-homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    tap-jira-cli = {
      url = "github:ankitpokhrel/homebrew-jira-cli";
      flake = false;
    };
    tap-mattt-tap = {
      url = "github:mattt/homebrew-tap";
      flake = false;
    };
    tap-nikitabobko-tap = {
      url = "github:nikitabobko/homebrew-tap";
      flake = false;
    };
    herdr = {
      url = "github:MaartenStaa/herdr/issue/1169-undercurl-color-not-rendered";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    # Herdr plugins
    herdr-plugin-plus = {
      url = "github:cloudmanic/herdr-plus/f32b0825f12543c1d03e54fb10d1741c40d66cdc";
      flake = false;
    };
    herdr-plugin-command-palette = {
      url = "github:JanTvrdik/herdr-command-palette/eab940018c2135ac23718efa11e23e9dddcd2a75";
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

    # Dependency of some flake inputs; lift here so we can deduplicate and follow nixpkgs
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-stable,
      catppuccin,
      home-manager,
      nix-darwin,
      nix-homebrew,
      oyui,
      tap-asheshgoplani-tap,
      tap-homebrew-bundle,
      tap-homebrew-cask,
      tap-homebrew-core,
      tap-jira-cli,
      tap-mattt-tap,
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
      desktop = {
        username = "maarten";
        email = "maarten@staa.dev";
        arch = "x86_64-linux";
      };
      mkSources =
        pkgs:
        import ./_sources/generated.nix {
          inherit (pkgs)
            fetchurl
            fetchFromGitHub
            dockerTools
            ;
          fetchgit =
            args:
            (pkgs.fetchgit args).overrideAttrs (old: {
              GIT_SSH_COMMAND = "${pkgs.openssh}/bin/ssh -o StrictHostKeyChecking=accept-new";
              impureEnvVars = (old.impureEnvVars or [ ]) ++ [ "SSH_AUTH_SOCK" ];
              preFetch = ''
                export GIT_SSH_COMMAND
              '';
            });
        };
    in
    {
      darwinConfigurations = with work; {
        work-mbp =
          let
            system = arch;
            pkgs = import nixpkgs {
              inherit system;
            };
            _sources = mkSources pkgs;
            args = {
              inherit
                username
                email
                ;
            };
          in
          nix-darwin.lib.darwinSystem {
            inherit system;
            specialArgs = args;
            modules = with args; [
              nix-homebrew.darwinModules.nix-homebrew

              {
                nix-homebrew = {
                  enable = true;
                  user = username;
                  taps = {
                    "ankitpokhrel/homebrew-jira-cli" = tap-jira-cli;
                    "asheshgoplani/homebrew-tap" = tap-asheshgoplani-tap;
                    "homebrew/homebrew-bundle" = tap-homebrew-bundle;
                    "homebrew/homebrew-cask" = tap-homebrew-cask;
                    "homebrew/homebrew-core" = tap-homebrew-core;
                    "mattt/homebrew-tap" = tap-mattt-tap;
                    "nikitabobko/homebrew-tap" = tap-nikitabobko-tap;
                    "spotify/homebrew-sptaps" = _sources.spotify-homebrew-sptaps.src;
                  };
                  trust.taps = [
                    "asheshgoplani/homebrew-tap"
                    "mattt/tap"
                    "nikitabobko/tap"
                    "spotify/sptaps"
                  ];
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
                    "asheshgoplani/homebrew-tap" = tap-asheshgoplani-tap;
                    "homebrew/homebrew-bundle" = tap-homebrew-bundle;
                    "homebrew/homebrew-cask" = tap-homebrew-cask;
                    "homebrew/homebrew-core" = tap-homebrew-core;
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
          let
            pkgs = nixpkgs.legacyPackages."${arch}";
            _sources = mkSources pkgs;
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit
                arch
                username
                email
                inputs
                oyui
                _sources
                ;
              system = arch;
            };
            modules = [
              catppuccin.homeModules.catppuccin

              ./modules/shared/config.nix

              ./modules/home-manager/asdf
              ./modules/home-manager/bazel.nix
              ./modules/home-manager/catppuccin.nix
              ./modules/home-manager/darwin.nix
              ./modules/home-manager/development.nix
              ./modules/home-manager/fd
              ./modules/home-manager/fzf.nix
              ./modules/home-manager/gcloud.nix
              ./modules/home-manager/ghostty
              ./modules/home-manager/git
              ./modules/home-manager/herdr
              ./modules/home-manager/home.nix
              ./modules/home-manager/jj
              ./modules/home-manager/karabiner
              ./modules/home-manager/kitty
              ./modules/home-manager/macos-apps.nix
              ./modules/home-manager/neovim
              ./modules/home-manager/pkgs.nix
              ./modules/home-manager/python.nix
              ./modules/home-manager/shell.nix
              ./modules/home-manager/tmux
              ./modules/home-manager/zed
            ];
          };

        private-mbp =
          with personal;
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages."${arch}";
            extraSpecialArgs = {
              inherit
                arch
                username
                email
                inputs
                oyui
                ;
              system = arch;
            };
            modules = [
              catppuccin.homeModules.catppuccin

              ./modules/shared/config.nix

              ./modules/home-manager/asdf
              ./modules/home-manager/catppuccin.nix
              ./modules/home-manager/darwin.nix
              ./modules/home-manager/development.nix
              ./modules/home-manager/fd
              ./modules/home-manager/fzf.nix
              ./modules/home-manager/ghostty
              ./modules/home-manager/git
              ./modules/home-manager/herdr
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
            ];
          };
      };

      nixosConfigurations = {
        maarten-pc =
          with desktop;
          let
            args = {
              inherit arch username email;
            };
          in
          nixpkgs-stable.lib.nixosSystem {
            system = arch;
            specialArgs = args;
            modules = [
              ./machines/desktop-pc
              ./modules/shared/config.nix

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = false;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  inherit (args) arch username email;
                  system = arch;
                };
                home-manager.users.${username}.imports = [
                  catppuccin.homeModules.catppuccin

                  ./modules/shared/config.nix

                  ./modules/home-manager/catppuccin.nix
                  ./modules/home-manager/development.nix
                  ./modules/home-manager/fd
                  ./modules/home-manager/fzf.nix
                  ./modules/home-manager/ghostty
                  ./modules/home-manager/git
                  ./modules/home-manager/herdr
                  ./modules/home-manager/home.nix
                  ./modules/home-manager/jj
                  ./modules/home-manager/linux.nix
                  ./modules/home-manager/neovim
                  ./modules/home-manager/pkgs.nix
                  ./modules/home-manager/python.nix
                  ./modules/home-manager/shell.nix
                  ./modules/home-manager/tmux
                ];
              }
            ];
          };
      };

      formatter = nixpkgs.lib.genAttrs [ work.arch personal.arch desktop.arch ] (
        system: nixpkgs.legacyPackages.${system}.nixfmt-tree
      );
    };
}
