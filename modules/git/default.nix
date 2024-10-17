{ pkgs, ... }: {
  home.packages = with pkgs; [
    gh
    git
    git-lfs
    lazygit
  ];

  programs.git = {
    enable = true;
    lfs = {
      enable = true;
    };
    userName = "Maarten Staa";
    userEmail = "maartens@spotify.com";
    extraConfig = {
      lfs = { enable = true; };
      core = {
        editor = "nvim";
        autocrlf = "input";
        whitespace = "trailing-space,space-before-tab";
      };
      grep = {
        extendRegexp = true;
        lineNumber = true;
      };
      rerere = {
        enabled = true;
      };
      pull = {
        ff = "only";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
