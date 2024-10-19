{ email, pkgs, ... }:
{
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
    userEmail = email;
    extraConfig = {
      lfs = {
        enable = true;
      };
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
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
      filters = {
        "lfs" = {
          required = true;
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
        };
      };
    };
    aliases = {
      fixup = "commit --amend --no-edit";
      butd = "!git fetch origin && git rebase origin/master";
      pf = "push --force-with-lease";
      ptb = "!git push -u $(whoami) $(git branch --show-current)";
    };
  };
}
