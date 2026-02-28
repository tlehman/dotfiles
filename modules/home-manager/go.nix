{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.tlehman.go.enable = lib.mkEnableOption "Go programming language";

  config = lib.mkIf config.tlehman.go.enable {
    home.packages = with pkgs; [
      go
      gopls
      golangci-lint
    ];
  };
}
