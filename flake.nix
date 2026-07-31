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

    # Packages to build from source
    herdr = {
      url = "github:MaartenStaa/herdr/issue/1169-undercurl-color-not-rendered";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    oyui = {
      url = "github:emilien-jegou/oyui";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust-overlay";
      };
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

    # Herdr plugins
    herdr-plugin-plus = {
      url = "github:cloudmanic/herdr-plus/f32b0825f12543c1d03e54fb10d1741c40d66cdc";
      flake = false;
    };
    herdr-plugin-command-palette = {
      url = "github:JanTvrdik/herdr-command-palette/eab940018c2135ac23718efa11e23e9dddcd2a75";
      flake = false;
    };

    opencode-vim.url = "github:leohenon/opencode-vim";
    opencode-vim.inputs.nixpkgs.follows = "nixpkgs";

    # Work-specific modules (private)
    spotify-dotfiles.url = "git+ssh://git@ghe.spotify.net/maartens/spotify-dotfiles.git";
    spotify-dotfiles.inputs.nixpkgs.follows = "nixpkgs";

    # Fish plugins
    fish-plugin-nvm = {
      url = "github:jorgebucaran/nvm.fish";
      flake = false;
    };

    # Kernel modules
    rtw89 = {
      url = "github:morrownr/rtw89";
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
    in
    {
      darwinConfigurations = with work; {
        work-mbp =
          let
            system = arch;
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
                  };
                  trust.taps = [
                    "asheshgoplani/homebrew-tap"
                    "mattt/tap"
                    "nikitabobko/tap"
                  ];
                  mutableTaps = false;
                };
              }

              inputs.spotify-dotfiles.darwinModules.default

              ./machines/work-mbp
              ./modules/nix-darwin/determinate.nix
              ./modules/nix-darwin/homebrew.nix
              ./modules/nix-darwin/pkgs.nix
              ./modules/shared/config.nix
            ];
          };
        personal-mbp =
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

              ./machines/personal-mbp
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
              inherit
                arch
                username
                email
                inputs
                ;
              system = arch;
            };
            modules = [
              ./modules/shared/config.nix
              ./modules/home-manager/shared
              ./modules/home-manager/darwin/shared
              ./modules/home-manager/darwin/work

              inputs.spotify-dotfiles.homeManagerModules.default
            ];
          };

        personal-mbp =
          with personal;
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages."${arch}";
            extraSpecialArgs = {
              inherit
                arch
                username
                email
                inputs
                ;
              system = arch;
            };
            modules = [
              ./modules/shared/config.nix
              ./modules/home-manager/shared
              ./modules/home-manager/darwin/shared
              ./modules/home-manager/darwin/personal
            ];
          };
      };

      nixosConfigurations = {
        maarten-pc =
          with desktop;
          let
            args = {
              inherit
                arch
                username
                email
                inputs
                ;
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
                home-manager = {
                  useGlobalPkgs = false;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    inherit inputs;
                    inherit (args) arch username email;
                    system = arch;
                  };

                  users.${username} = {
                    # This is what makes Home Manager actually use the unstable nixpkgs input,
                    # rather than defaulting to the stable NixOS one (even with `useGlobalPkgs
                    # = false`).
                    _module.args.pkgsPath = inputs.nixpkgs;

                    imports = [
                      ./modules/shared/config.nix
                      ./modules/home-manager/shared
                      ./modules/home-manager/linux
                    ];
                  };
                };
              }
            ];
          };
      };

      formatter = nixpkgs.lib.genAttrs [ work.arch personal.arch desktop.arch ] (
        system: nixpkgs.legacyPackages.${system}.nixfmt-tree
      );
    };
}
