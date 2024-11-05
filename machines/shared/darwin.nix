{ pkgs, username, ... }:
{
  # Allow running of proprietary software (e.g. Obsidian)
  nixpkgs.config.allowUnfree = true;
  nixpkgs.flake.setNixPath = true;

  services.nix-daemon.enable = true;
  nix = {
    useDaemon = true;
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
      "alfred"
      "arc"
      "betterdisplay"
      "dash"
      "deskpad"
      "docker"
      "firefox@developer-edition"
      "karabiner-elements"
      "kitty"
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
    global = {
      autoUpdate = false;
    };
    onActivation = {
      cleanup = "zap";
    };
  };

  # TODO: Add system defaults
  security = {
    pam.enableSudoTouchIdAuth = true;
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
