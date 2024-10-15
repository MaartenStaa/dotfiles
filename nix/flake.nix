{
  description = "Maarten's macOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager.url = "github:nix-community/home-manager/release-24.05";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, ... }: {
      # Allow running of proprietary software (e.g. Obsidian)
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          # Command line tools
          pkgs.ack
          pkgs.bat
          pkgs.curl
          pkgs.diff-so-fancy
          pkgs.exiftool
          pkgs.eza
          pkgs.fd
          pkgs.ffmpeg
          pkgs.fish
          pkgs.fzf
          pkgs.gnupg
          pkgs.htop
          pkgs.inetutils
          pkgs.jq
          pkgs.neovim
          pkgs.neovim-remote
          pkgs.reattach-to-user-namespace
          pkgs.ripgrep
          pkgs.silver-searcher
          pkgs.tldr
          pkgs.tree
          pkgs.tmux
          pkgs.wget
          pkgs.zoxide
          pkgs.zsh

          # General software development
          pkgs.cloc
          pkgs.ctags
          pkgs.gh
          pkgs.git
          pkgs.git-lfs
          pkgs.google-cloud-sdk
          pkgs.lazygit
          pkgs.snyk
          pkgs.tree-sitter

          # Programming languages
          pkgs.buildifier # Bazel
          pkgs.buildozer # Bazel
          pkgs.rustup # Rust
          pkgs.ruff # Python
          pkgs.uv # Python

          # Smart home
          pkgs.esptool

          # GUI applications
          # pkgs.karabiner-elements
          pkgs.kitty
          pkgs.obsidian
          pkgs.slack

          # Not available on aarch64-darwin
          # pkgs.todoist-electron
          # pkgs.sublime4
          # pkgs.sublime-merge
        ];

      fonts.packages =
        [
          (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        ];

      homebrew = {
        enable = true;
        brews = [
          "mas"
        ];
        taps = [
          "nikitabobko/tap"
        ];
        casks = [
          "alfred"
          "arc"
          "betterdisplay"
          "dash"
          "deskpad"
          "docker"
          "firefox@developer-edition"
          "karabiner-elements"
          "home-assistant"
          "iina"
          "moom"
          "aerospace"
          "sublime-merge"
          "sublime-text"
          "todoist"
        ];
        masApps = {
          "Consent-O-Matic" = 1606897889;
        };
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
        onActivation.cleanup = "zap";
      };

      # Make these shells available as options for `chsh`.
      environment.shells = [ pkgs.fish pkgs.zsh ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Home Manager
      # home-manager.users."maartens" = {
      #   name = "Maarten";
      #   programs.fish.enable = true;
      # };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # enableRosetta = true;
            user = "maartens";
            autoMigrate = true;
          };
        }
        # home-manager.darwinModules.home-manager
        # {
        #   home-manager.stateVersion = "24.05";
        #   home-manager.users.maartens = {
        #     programs.fish.enable = true;
        #   };
        # }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mbp".pkgs;
  };
}
