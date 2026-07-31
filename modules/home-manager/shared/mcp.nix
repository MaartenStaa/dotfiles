{ pkgs, ... }: {
  programs.mcp = {
    enable = true;
    servers = {
      craft.url = "https://mcp.craft.do/links/5WsXOS9Idjl/mcp";

      home-assistant = {
        command = "${pkgs.uv}/bin/uvx";
        args = [
          "--python"
          "3.13"
          "ha-mcp"
        ];
      };
    };
  };
}
