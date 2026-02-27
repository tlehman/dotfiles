{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.tlehman.k9s.enable = lib.mkEnableOption "k9s terminal UI for Kubernetes";

  config = lib.mkIf config.tlehman.k9s.enable {
    programs.k9s = {
      enable = true;
      settings = {
        k9s = {
          liveViewAutoRefresh = false;
          refreshRate = 2;
          maxConnRetry = 5;
          readOnly = false;
          noExitOnCtrlC = false;
          ui = {
            skin = "default";
            defaultskin = "default";
          };
        };
      };
    };
  };
}
