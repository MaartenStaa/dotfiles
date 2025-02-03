{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    luarocks
    neovim
    ctags
    tree-sitter
    python312Packages.pynvim
  ];

  # https://mynixos.com/nixpkgs/options/programs.neovim
  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #   viAlias = true;
  #   vimAlias = true;
  #   withPython3 = true;
  # };

  xdg.configFile = {
    nvim = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/neovim/config";
    };
    ideavimrc = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/.ideavimrc";
    };
  };
}
