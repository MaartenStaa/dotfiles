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
    signing = {
      format = null;
    };
    settings = {
      user = {
        name = "Maarten Staa";
        inherit email;
      };
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
      alias = {
        fixup = "commit --amend --no-edit";
        butd = "!git fetch origin && git rebase origin/master";
        pf = "push --force-with-lease";
        ptb = "!git push -u $(whoami) $(git branch --show-current)";
        pt = "!git push -u origin $(git branch --show-current)";
        uncommit = "reset --soft HEAD~";
      };
    };
    includes = [
      { path = "local.conf"; }
    ];
  };
}
