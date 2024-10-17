{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font Mono Light";
      bold_font = "JetBrainsMono Nerd Font Mono Bold";
      italic_font = "JetBrainsMono Nerd Font Mono Light Italic";
      bold_italic_font = "JetBrainsMono Nerd Font Mono Bold Italic";

      font_size = 14;

      enabled_layouts = "all";

      tab_bar_style = "powerline";
      tab_powerline_style = "round";

      shell = "${pkgs.fish}/bin/fish --login --interactive";
      editor = "${pkgs.neovim}/bin/nvim";
      env = ''
        SHELL=${pkgs.fish}/bin/fish
      '';

      term = "tmux-256color";
      shell_integration = true;
    };
    themeFile = "Catppuccin-Macchiato";
  };
}
