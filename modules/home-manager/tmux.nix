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
      extraConfig = ''
        bind s display-popup -E "tmux list-sessions -F '#{session_name}' | fzf --reverse | xargs tmux switch-client -t"
      '';
    };
  };
}
