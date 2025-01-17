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
      delve
      go
      gofumpt
      gomodifytags
      gopls
      gotools
      impl
      # Java
      jdt-language-server
      # vscode-extensions.vscjava.vscode-java-debug # TODO: This doesn't actually provide the right executable
      # vscode-extensions.vscjava.vscode-java-test # TODO: This doesn't actually provide the right executable
      # JavaScript / TypeScript
      corepack
      dockerfile-language-server-nodejs
      # eslintd
      nodejs
      # oxlint
      # typescript-language-server # TODO: Remove? Replaced by vtsls?
      vscode-js-debug
      vtsls
      yarn
      # Kotlin
      ktlint
      ktfmt
      # Markdown
      # markdown-toc # TODO: This npm package doesn't exist
      markdownlint-cli2
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
      pytest
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
      # vscode-extensions.vadimcn.vscode-lldb # TODO: This is currently broken, and doesn't provide the right executable
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
      # YAML
      yaml-language-server
      yamllint
      # Various
      vscode-langservers-extracted
    ];
}
