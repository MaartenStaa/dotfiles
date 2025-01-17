{ pkgs, ... }:
{

  home.packages =
    with pkgs;
    with pkgs.python312Packages;
    with pkgs.luajitPackages;
    [
      # Programming languages, language servers, and formatters
      # Bazel
      buildifier
      buildozer
      starlark-rust
      # CSS
      # css-lsp
      # cssmodules-language-server
      # Lua
      lua
      lua-language-server
      luacheck
      # Go
      go
      gopls
      # Java
      jdt-language-server
      # JavaScript
      corepack
      dockerfile-language-server-nodejs
      # eslintd
      nodejs
      # oxlint
      yarn
      # Markdown
      marksman
      # Nix
      nil
      nixfmt-rfc-style
      nixpkgs-fmt
      # Python
      autopep8
      black
      flake8
      jedi-language-server
      pylsp-mypy
      pylsp-rope
      pyright
      python-lsp-ruff
      python-lsp-server
      python3
      ruff
      uv
      # Rust
      cargo
      clippy
      rust-analyzer
      rustc
      rustfmt
      # Shell scripts
      bash-language-server
      shellcheck
      shfmt
      # Swift
      clang-tools # clang-format and such
      swiftlint
      swiftformat
      # TOML
      taplo
      # TypeScript
      typescript-language-server
      # YAML
      yaml-language-server
      yamllint
      # Various
      vscode-langservers-extracted
    ];
}
