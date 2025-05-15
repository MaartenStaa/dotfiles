{ config, pkgs, ... }:
{
  xdg.configFile = {
    ghostty-link = {
      target = "ghostty/config";
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/ghostty/config";
    };

    ghostty-nix = {
      target = "ghostty/config-generated";
      text = # ini
        ''
          command = ${pkgs.fish}/bin/fish --login --interactive
        '';
    };
  };
}
