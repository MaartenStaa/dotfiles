{ pkgs, ... }:
let
  python-with-packages = pkgs.python312.withPackages (
    pp: with pp; [
      autopep8
      black
      debugpy
      flake8
      jedi-language-server
      pylsp-mypy
      pylsp-rope
      pynvim
      pytest
      python-lsp-ruff
      python-lsp-server
    ]
  );
in
{
  home.sessionVariables = {
    PTYTHONPATH = "${python-with-packages}/${python-with-packages.sitePackages}";
  };
}
