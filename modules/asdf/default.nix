{ pkgs, inputs, ... }:
let
  plugins = [
    "python"
    "nodejs"
  ];
  pluginSources = {
    asdf-nodejs = inputs."asdf-nodejs";
    # Path asdf-python to allow setting the runtime data dir to somewhere we can write
    asdf-python = pkgs.stdenv.mkDerivation {
      name = "asdf-python";
      version = "${inputs.asdf-python.rev}-patched";
      src = inputs."asdf-python";
      phases = [
        "unpackPhase"
        "patchPhase"
        "buildPhase"
      ];
      patches = [ ./asdf-python.patch ];
      buildPhase = ''cp -r . $out'';
    };
  };
in
{
  home.packages = with pkgs; [
    asdf-vm
  ];

  home.file = builtins.listToAttrs (
    builtins.map (plugin: {
      name = ".asdf/plugins/${plugin}";
      value = {
        source = pluginSources."asdf-${plugin}";
      };
    }) plugins
  );

  # Work around permission problems with asdf
  programs.fish.loginShellInit = ''
    export ASDF_NODEJS_NODEBUILD_HOME="$HOME/.asdf/build/node-build";
    export ASDF_PYTHON_DATA_DIR="$HOME/.asdf/build/python";
  '';
}
