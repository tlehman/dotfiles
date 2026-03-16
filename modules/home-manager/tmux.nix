{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.tlehman.tmux.enable = lib.mkEnableOption "Tobi's tmux";

  config = lib.mkIf config.tlehman.tmux.enable {
    programs.tmux = {
      enable = true;
      mouse = true;
    };
  };
}
