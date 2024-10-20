{ pkgs, username, ... }:
{
  # Allow running of proprietary software (e.g. Obsidian)
  nixpkgs.config.allowUnfree = true;

  services.nix-daemon.enable = true;
  nix.useDaemon = true;
  nix.package = pkgs.nix;
  nix.settings.trusted-users = [
    "root"
    username
  ];
  system.stateVersion = 5;

  # Storage management on upgrades
  nix.gc.automatic = true;
  nix.settings.auto-optimise-store = false;

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
