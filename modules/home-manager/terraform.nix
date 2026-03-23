{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.tlehman.terraform.enable = lib.mkEnableOption "Terraform";

  config = lib.mkIf config.tlehman.terraform.enable {
    home.packages = [ pkgs.terraform ];
  };
}
