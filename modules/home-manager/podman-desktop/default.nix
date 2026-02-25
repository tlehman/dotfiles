{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.tlehman.podman-desktop.enable = lib.mkEnableOption "Podman Desktop";
  config = lib.mkIf config.tlehman.podman-desktop.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs) cri-tools podman podman-desktop;
    };

    xdg.configFile."containers/containers.conf".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/src/tlehman/dotfiles/config/containers/containers.conf"
    );

    xdg.dataFile."containers/podman-desktop/configuration/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink
        (
          config.home.homeDirectory + "/src/tlehman/dotfiles/config/containers/podman-desktop-settings.json"
        );
  };
}
