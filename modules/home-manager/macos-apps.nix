{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    mkalias
  ];

  home.activation.alias-applications =
    let
      appsDirectory = "${config.home.homeDirectory}/Applications/Nix Apps";
      env = pkgs.buildEnv {
        name = "hm-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
    in
    lib.hm.dag.entryAfter [ "writeBoundary" "linkGeneration" ]
      # bash
      ''
        # Set up applications.
        set -eu
        echo "setting up ${appsDirectory}..." >&2
        rm -rf ${lib.escapeShellArg appsDirectory}
        mkdir -p ${lib.escapeShellArg appsDirectory}
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "${appsDirectory}/$app_name"
        done
      '';
}
