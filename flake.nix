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
  };

  outputs = { nixpkgs, catppuccin, home-manager, nix-darwin, ... }: {
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
          {
            options.custom.username = nixpkgs.lib.mkOption {
              type = nixpkgs.lib.types.str;
              description = "The username of the user";
            };

            config.custom.username = "maartens";
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
        ];
      };
    };
  };
}
