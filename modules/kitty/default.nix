{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    environment = {
      SHELL = "${pkgs.fish}/bin/fish";
    };
    font = {
      name = "JetBrainsMono Nerd Font Mono Light";
      package = with pkgs; (nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
      size = 14;
    };
    settings = {
      enabled_layouts = "all";

      tab_bar_style = "powerline";
      tab_powerline_style = "round";

      shell = "${pkgs.fish}/bin/fish --login --interactive";
      editor = "${pkgs.neovim}/bin/nvim";

      term = "tmux-256color";
      shell_integration = true;
    };
    shellIntegration = {
      enableFishIntegration = true;
    };
    themeFile = "Catppuccin-Macchiato";
  };
}
