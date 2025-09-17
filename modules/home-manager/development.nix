{ pkgs, ... }:
{
  home.packages =
    with pkgs;
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
      deno
      dockerfile-language-server
      # eslintd
      nodejs
      # oxlint
      # typescript-language-server # TODO: Remove? Replaced by vtsls?
      vscode-js-debug
      vtsls
      # Kotlin
      detekt
      ktlint
      ktfmt
      # Lua
      stylua
      # Markdown
      # markdown-toc # TODO: This npm package doesn't exist
      markdownlint-cli2
      marksman
      # Nix
      nil
      nixfmt-rfc-style
      nixpkgs-fmt
      # Python
      pyright
      python312
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

      # Utilities
      # AI
      claude-code
    ];
}
