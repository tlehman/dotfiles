{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.tlehman.neovim.enable = lib.mkEnableOption "Neovim";

  config = lib.mkIf config.tlehman.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
