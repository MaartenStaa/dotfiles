{ inputs, pkgs, ... }:
with builtins;
let
  inputNames = attrNames inputs;
  paths = map (
    input:
    let
      path = getAttr input inputs;
    in
    "${input}=${path.outPath}"
  ) inputNames;
  nixPath = concatStringsSep ":" paths;
in
{
  # https://mynixos.com/home-manager/options/programs.nushell
  programs.nushell = {
    enable = true;
    settings = {
      buffer_editor = "${pkgs.neovim}/bin/nvim";
      edit_mode = "vi";
      show_banner = false;
    };
    environmentVariables = {
      NIX_PATH = nixPath;
    };
    shellAliases = {
      art = "php artisan";
      brewu = "brew update and brew upgrade";
      cat = "bat";
      code = "`/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code`";
      dc = "docker compose";
      dcb = "docker compose build";
      dce = "docker compose run app";
      dcr = "docker compose run app";
      dcsh = "docker compose exec app ash";
      dcu = "docker compose up";
      gb = "git branch";
      gc = "git commit";
      gcn = "git commit --no-edit";
      gco = "git checkout";
      gf = "git fetch";
      giA = "git add -p";
      gia = "git add";
      gid = "git diff --no-ext-diff --cached";
      gl = "git log";
      gp = "git push";
      gpf = "git push --force-with-lease";
      gpr = "git pull --prune";
      gs = "git status";
      gwd = "git diff --no-ext-diff";
      lg = "lazygit";
      ll = "eza -hal";
      ls = "eza";
      pn = "pnpm";
      psi = "pnpm submodules and pnpm install --frozen-lockfile";
      subl = "`/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl`";
      vim = "nvim";
      yup = "yarn submodules and yarn install --frozen-lockfile";
    };
    extraConfig =
      builtins.readFile ./config.nu
      +
      # nu
      ''
        def gbn [
          name: string
        ] {
          git checkout -b $"maartens/($name)" origin/master
        }
      '';
  };
}
