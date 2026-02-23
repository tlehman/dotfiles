{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.tlehman.zsh.enable = lib.mkEnableOption "Tobi's zsh";
  config = lib.mkIf config.tlehman.zsh.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting = {
        enable = true;
      };
      history = {
        size = 100000;
        save = 10000000;
      };

      shellAliases = {
        ls = "${pkgs.eza}/bin/eza --icons --hyperlink";
        ld = "ls -D";
        ll = "ls -lhF";
        la = "ls -lahF";
        l = "la";
        t = "ls -T -I '.git'";
        cat = "bat";
        ".." = "cd ..;";
        "..." = ".. ..";
        zed = "open -a Zed";
      };

      initContent = builtins.readFile ./initExtra.sh;
    };
  };
}
