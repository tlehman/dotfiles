{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.tlehman.zed.enable = lib.mkEnableOption "Zed editor";
  config = lib.mkIf config.tlehman.zed.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs) zed-editor;
    };
  };
}
