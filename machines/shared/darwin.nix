{ pkgs, username, ... }:
{
  # Allow running of proprietary software (e.g. Obsidian)
  nixpkgs.config.allowUnfree = true;
  nixpkgs.flake.setNixPath = true;

  nix = {
    package = pkgs.nix;
    settings.trusted-users = [
      "root"
      username
    ];

    # Storage management on upgrades
    gc.automatic = true;
    settings.auto-optimise-store = false;
  };

  system.stateVersion = 5;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    casks = [
      "aerospace"
      "alfred"
      "arc"
      "betterdisplay"
      "dash"
      "deskpad"
      "docker"
      "firefox@developer-edition"
      "home-assistant"
      "iina"
      "karabiner-elements"
      "kitty"
      "moom"
      "neovide"
      "sublime-merge"
      "sublime-text"
      "todoist"
    ];
    masApps = {
      "Consent-O-Matic" = 1606897889;
    };
    global = {
      autoUpdate = false;
    };
    onActivation = {
      cleanup = "zap";
    };
  };

  # TODO: Add system defaults
  security = {
    pam.services.sudo_local.touchIdAuth = true;
  };
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.4;
    };
    finder = {
      AppleShowAllExtensions = true;
    };
  };
}
