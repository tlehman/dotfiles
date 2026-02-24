{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.tlehman.zed.enable = lib.mkEnableOption "Zed editor";
  config = lib.mkIf config.tlehman.zed.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs) zed-editor;
    };

    xdg.configFile."zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/src/tlehman/dotfiles/config/zed/settings.json"
    );
  };
}
