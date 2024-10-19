{ pkgs, ... }:
{
  # https://mynixos.com/home-manager/options/programs.fish
  programs.fish = {
    enable = true;
    functions = {
      gh_pr_comments = {
        body = ''
          gh pr list -A $(id -un) -s open --json number --jq ".[].number" | xargs -I {} gh pr view {} --comments --json title,comments --jq '.comments |= map(select(.author.login | test("bot|ci") | not)) | .comments |= map(.body) | .title,.comments' | bat
        '';
        description = "Print comments for all open PRs for the current user";
      };
    };
    plugins = with pkgs.fishPlugins; [
      {
        name = "bass";
        src = bass.src;
      }
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
      {
        name = "nvm";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "nvm.fish";
          rev = "2.2.16";
          sha256 = "sha256-GTEkCm+OtxMS3zJI5gnFvvObkrpepq1349/LcEPQRDo=";
        };
      }
    ];
    shellAbbrs = {
      dcr = "docker compose run app";
      dc = "docker compose";
      dce = "docker compose run app";
      dcb = "docker compose build";
      gc = "git commit";
      gco = "git checkout";
      yup = "yarn submodules && yarn install --frozen-lockfile";
      dcu = "docker compose up";
      brewu = "brew update && brew upgrade";
      gb = "git branch";
      dcsh = "docker compose exec app ash";
      giA = "git add -p";
      gia = "git add";
      gwd = "git diff --no-ext-diff";
      gid = "git diff --no-ext-diff --cached";
      gl = "git log";
      gcn = "git commit --no-edit";
      gp = "git push";
      ll = "eza -hal";
      gpf = "git push --force-with-lease";
      gs = "git status";
      ls = "eza";
      psi = "pnpm submodules && pnpm install --frozen-lockfile";
      vim = "nvim";
      code = "/Applications/Visual\\\ Studio\\\ Code.app/Contents/Resources/app/bin/code";
      cat = "bat";
      pn = "pnpm";
      subl = "/Applications/Sublime\\\ Text.app/Contents/SharedSupport/bin/subl";
      art = "php artisan";
      lg = "lazygit";
    };
    shellInitLast =
      builtins.readFile ./config.fish
      + ''
        export EDITOR=${pkgs.neovim}/bin/nvim
        export VISUAL=${pkgs.neovim}/bin/nvim
      '';
  };
}
