{ lib, config, ... }:
{
  options.tlehman.homebrew.enable = lib.mkEnableOption "Tobi's Homebrew stuff";
  config = lib.mkIf config.tlehman.homebrew.enable {
    homebrew = {
      enable = true;
      global.brewfile = true;
      onActivation = {
        upgrade = true;
        cleanup = "zap";
        autoUpdate = true;
      };
      taps = [ ];
      casks = [ "obsidian" ];
      brews = [ ];
    };
  };
}
