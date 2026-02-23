{ lib, config, ... }:
{
  options.tlehman.starship.enable = lib.mkEnableOption "Tobi's starship";
  config = lib.mkIf config.tlehman.starship.enable {
    programs.starship = {
      enable = true;
      settings = {
        aws.disabled = true;
        gcloud.disabled = true;
      };
    };
  };
}
