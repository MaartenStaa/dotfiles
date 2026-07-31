{ pkgs, ... }: {
  programs.mcp = {
    enable = true;
    servers = {
      dash-api = {
        command = "${pkgs.uv}/bin/uvx";
        args = [
          "--from"
          "git+https://github.com/Kapeli/dash-mcp-server.git"
          "dash-mcp-server"
        ];
      };

      imcp.command = "/Applications/iMCP.app/Contents/MacOS/imcp-server";

      spark = {
        command = "${pkgs.uv}/bin/uv";
        args = [
          "run"
          "--directory"
          "/Users/maartens/src-github/spark-mcp"
          "-m"
          "spark_mcp.server"
        ];
      };

      things = {
        command = "${pkgs.uv}/bin/uvx";
        args = [
          "things-mcp"
        ];
      };
    };
  };
}
