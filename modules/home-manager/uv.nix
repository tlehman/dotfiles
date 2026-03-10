{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.tlehman.uv.enable = lib.mkEnableOption "uv Python package manager";

  config = lib.mkIf config.tlehman.uv.enable {
    home.packages = with pkgs; [
      uv
    ];
  };
}
