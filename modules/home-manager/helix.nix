{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.tlehman.helix.enable = lib.mkEnableOption "Helix editor";

  config = lib.mkIf config.tlehman.helix.enable {
    programs.helix = {
      enable = true;
      defaultEditor = false;
      settings = {
        theme = "onedark";
        editor = {
          line-number = "relative";
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          lsp.display-messages = true;
        };
      };
    };
  };
}
