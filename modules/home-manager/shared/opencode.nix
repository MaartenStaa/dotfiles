{
  inputs,
  system,
  ...
}:
{
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    package = inputs.opencode-vim.packages.${system}.opencode;
    settings = {
      autoupdate = false;
      lsp = true;
      formatter = true;
      watcher = {
        ignore = [
          ".git/**"
          "bazel-*/**"
          "node_modules/**"
          "target/**"
        ];
      };
    };
    tui = {
      vim = true;
      vim_modal_input = true;
      vim_system_clipboard_register = true;
      vim_insert_after_submit = true;
      vim_showbreak = true;
      keybinds = {
        input_force_submit = "ctrl+return";
        vim.normal = {
          input_line_home = "shift+h";
          input_line_end = "shift+l";
        };
      };
      theme = "catppuccin-macchiato";
    };
  };
}
