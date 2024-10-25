{ config, pkgs, ... }:
{
  home.packages =
    with pkgs;
    with pkgs.python312Packages;
    with pkgs.luajitPackages;
    [
      neovim
      ctags
      tree-sitter

      # Programming languages
      # Bazel
      buildifier
      buildozer
      # Lua
      lua
      # JavaScript
      nodejs
      # Python
      python3
      ruff
      uv
      # Rust
      cargo
      clippy
      rustc
      rustfmt

      # Language server plugins
      autopep8
      bash-language-server
      clang-tools # clang-format and such
      # css-lsp
      # cssmodules-language-server
      dockerfile-language-server-nodejs
      # eslintd
      flake8
      gopls
      jdt-language-server
      jedi-language-server
      lua-language-server
      luacheck
      marksman
      # mesonlsp
      nil
      nixfmt-rfc-style
      nixpkgs-fmt
      # oxlint
      pylsp-mypy
      pylsp-rope
      python-lsp-ruff
      python-lsp-server
      rust-analyzer
      shellcheck
      starlark-rust
      # swift-mesonlsp
      # swiftlint
      taplo
      # vim-language-server TODO: Fix
      vscode-langservers-extracted
      yaml-language-server
      yamllint
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
