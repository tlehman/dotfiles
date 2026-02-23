{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.tlehman.yazi.enable = lib.mkEnableOption "Tobi's yazi";
  config = lib.mkIf config.tlehman.yazi.enable {
    programs.yazi = {
      enable = lib.mkDefault true;
      shellWrapperName = "y";
      enableZshIntegration = true;
      plugins = with pkgs.yaziPlugins; {
        inherit git piper;
      };
      initLua = ''
        require("git"):setup()
      '';

      settings = {
        mgr.ratio = [
          1
          2
          3
        ];
        plugin = {
          prepend_fetchers = [
            {
              id = "git";
              name = "*";
              run = "git";
            }
            {
              id = "git";
              name = "*/";
              run = "git";
            }
          ];
          prepend_previewers = [
            {
              name = "*.(py|sh|go|ts|css|yaml|yml|toml|html|conf|json|csv|nix)";
              run = "bat";
            }
          ];
        };
      };
    };
  };
}
